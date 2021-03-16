love.errorhandler = require("utils.errorhandler")
local argparse = require("lib.argparse")
local ScreenManager = require("ui.ScreenManager")
local joystickManager = require("utils.joystickManager")
local console = require("utils.console")
local mouseUtils = require("utils.mouse")
local musicManager = require("utils.musicManager")
local scheduler = require("utils.scheduler")
local settings = require("utils.settings")
local languageUtils = require("utils.language")
local Steam = require("luasteam")
local storage = require("utils.storage")

GLOBAL_DEBUG_ENABLED = true
GLOBAL_HUD_DISABLED = false
GLOBAL_DEBUG_UNLOCK_ALL_LEVELS = true

local isInitialized = false

local debugSimulateFrameRate = 30
local debugUpdateDelay = 0
local debugNoSteam = false

local steamUpdateInterval = 0.1
local steamLastUpdatedAt = love.timer.getTime()

local screenManager

---------------------
-- Local functions --
---------------------

local function completeInitialization()
    if isInitialized then
        return
    end

    local steamUserId = "local"

    -- Initialize Steam
    pcall(function ()
        local steamInitStartAt = love.timer.getTime()
        if not debugNoSteam and Steam.init() then
            steamUserId = tostring(Steam.user.getSteamID())
        elseif not debugNoSteam then
            error("Steam must be running")
            return
        end
        print("Steam initalization completed in", math.floor((love.timer.getTime() - steamInitStartAt) * 1000) / 1000, "s")
    end)

    -- Load game saves
    love.filesystem.createDirectory(steamUserId)
    storage.load(steamUserId.."/user_progress.bin")

    screenManager:emit("handleInitializationFinish")
    isInitialized = true
end

----------------------
-- Love2d callbacks --
----------------------

function love.load(arg)
    console.overridePrint()
    print("Game started")

    -- Parse command-line arguments
    local parser = argparse()
    parser:flag("--debug", "Run game in debug mode")
    parser:option("--level", "Force load game level")
    parser:option("--screen", "Force display screen")
    parser:option("--fps", "Simulate frame rate")
    parser:flag("--maximize", "Force maximize window")
    parser:flag("--nohud", "Disable HUD")
    parser:flag("--nosteam", "Allow running without Steam")
    parser:flag("--nosplash", "Skip splash screen")
    local args = parser:parse(arg)

    GLOBAL_DEBUG_ENABLED = GLOBAL_DEBUG_ENABLED or args.debug
    GLOBAL_DEBUG_UNLOCK_ALL_LEVELS = GLOBAL_DEBUG_UNLOCK_ALL_LEVELS and GLOBAL_DEBUG_ENABLED
    GLOBAL_HUD_DISABLED = not not args.nohud
    debugNoSteam = debugNoSteam or not not args.nosteam
    debugSimulateFrameRate = tonumber(args.fps) or 0

    -- Lua initialization
    math.randomseed(os.time())

    -- Love2D initalization
    love.window.setIcon(love.image.newImageData("assets/window_icon.png"))

    settings.load()
    if not settings.get("language") then
        settings.set("language", languageUtils.getSystemLanguage())
    end

    -- Initalize UI and show first screen
    screenManager = ScreenManager:new()
    if args.level then
        completeInitialization()
        print("Force load level", args.level)
        screenManager:transition("GameScreen", args.level)
    elseif args.screen then
        print("Force load screen", args.screen)
        completeInitialization()
        screenManager:transition(args.screen)
    elseif args.nosplash then
        completeInitialization()
        screenManager:transition("MainMenuScreen")
    else
        screenManager:transition("SplashScreen")
    end
end

function love.quit()
    local x, y, display = love.window.getPosition()
    settings.set("window_x", math.max(1, x))
    settings.set("window_y", math.max(1, y))
    settings.set("window_display", display)

    Steam.shutdown()
end

function love.update(deltaTime)
    if not isInitialized and screenManager.fadeProgress < 0.01 then
        completeInitialization()
    end

    -- Update Steam integration
    if isInitialized and love.timer.getTime() - steamLastUpdatedAt > steamUpdateInterval then
        steamLastUpdatedAt = love.timer.getTime()
        Steam.runCallbacks()
    end

    -- Don't update game if it's frozen
    if deltaTime > 0.5 then
        return
    end

    scheduler.update(deltaTime)
    mouseUtils.update()
    screenManager:update(deltaTime)
    musicManager:update(deltaTime)

    if GLOBAL_DEBUG_ENABLED and debugSimulateFrameRate > 0 then
        debugUpdateDelay = debugUpdateDelay + deltaTime
        if debugUpdateDelay > (1000 / debugSimulateFrameRate) / 1000 then
            screenManager:emit("update", debugUpdateDelay)
            debugUpdateDelay = 0
        end
    else
        screenManager:emit("update", deltaTime)
    end
end

function love.draw()
    screenManager:emit("draw")
    screenManager:draw()

    console.draw()
end

function love.keypressed(key, ...)
    screenManager:emit("handleKeyPress", key, ...)

    if key == "`" and GLOBAL_DEBUG_ENABLED then
        console.toggle()
    elseif key == "f11" then
        love.window.setFullscreen(not love.window.getFullscreen(), "exclusive")
    elseif key == "r" and love.keyboard.isDown("lctrl") and love.keyboard.isDown("lshift") then
        love.event.quit("restart")
    end
end

function love.keyreleased(...)
    screenManager:emit("handleKeyRelease", ...)
end

function love.mousepressed(...)
    screenManager:emit("handleMousePress", ...)
end

function love.focus(isFocused)
    screenManager:emit("handleWindowFocus", isFocused)
end

function love.joystickadded(joystick)
    joystickManager.add(joystick)
end

function love.joystickremoved(joystick)
    joystickManager.remove(joystick)
end

function love.resize(width, height)
    if settings.get("window_mode") == "windowed" then
        settings.set("window_width", width)
        settings.set("window_height", height)
    end
    screenManager:emit("handleWindowResize", width, height)
end

---------------------
-- Steam callbacks --
---------------------

function Steam.friends.onGameOverlayActivated(data)
    screenManager:emit("handleWindowFocus", not data.active)
end

-----------------------
-- Settings handlers --
-----------------------

settings.addHandler("window_mode", function (value)
    if not isInitialized then
        return
    end

    if value == "windowed" then
        love.window.updateMode(settings.get("window_width"), settings.get("window_height"), {
            fullscreen = false,
        })
    elseif value == "borderless" then
        love.window.updateMode(0, 0, {
            fullscreen = true,
            fullscreentype = "desktop",
        })
    else
        love.window.updateMode(0, 0, {
            fullscreen = true,
            fullscreentype = "exclusive",
        })
    end
end)

settings.addHandler("vsync", function (value)
    if value then
        love.window.setVSync(-1)
    else
        love.window.setVSync(0)
    end
end)

settings.addHandler("master_volume", function (value)
    love.audio.setVolume(value)
end)

settings.addHandler("language", function (value)
    languageUtils.loadLanguage(value)
end)