love.errorhandler = require("utils.errorhandler")
local argparse = require("lib.argparse")
local ScreenManager = require("ui.ScreenManager")
local joystickManager = require("utils.joystickManager")
local console = require("utils.console")
local mouseUtils = require("utils.mouse")
local musicManager = require("utils.musicManager")
local scheduler = require("utils.scheduler")
local settings = require("utils.settings")
local storage = require("utils.storage")
local languageUtils = require("utils.language")
local Steam = require("luasteam")

GLOBAL_DEBUG_ENABLED = true
GLOBAL_HUD_DISABLED = false

local debugSimulateFrameRate = 30
local debugUpdateDelay = 0
local debugNoSteam = false

local steamUpdateInterval = 0.1
local steamLastUpdatedAt = love.timer.getTime()

local screenManager

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
    local args = parser:parse(arg)

    GLOBAL_DEBUG_ENABLED = GLOBAL_DEBUG_ENABLED or args.debug
    GLOBAL_HUD_DISABLED = not not args.nohud
    debugSimulateFrameRate = tonumber(args.fps) or 0

    -- Lua initialization
    math.randomseed(os.time())

    -- Love2D initalization
    love.window.setIcon(love.image.newImageData("assets/window_icon.png"))

    languageUtils.loadLanguage()
    settings.load()

    local steamInitStartAt = love.timer.getTime()
    -- Initialize Steam
    local steamUserId = "local"
    if Steam.init() then
        steamUserId = tostring(Steam.user.getSteamID())
    elseif not debugNoSteam then
        error("Steam must be running")
        return
    end
    print("Steam initalization completed in", math.floor((love.timer.getTime() - steamInitStartAt) * 1000) / 1000, "s")

    -- Load game saves
    love.filesystem.createDirectory(steamUserId)
    storage.load(steamUserId.."/user_progress.bin")

    -- Initalize UI and show first screen
    screenManager = ScreenManager:new()
    if args.level then
        print("Force load level", args.level)
        screenManager:transition("GameScreen", args.level)
    elseif args.screen then
        print("Force load screen", args.screen)
        screenManager:transition(args.screen)
    else
        screenManager:transition("MainMenuScreen")
    end
end

function love.quit()
    local x, y, display = love.window.getPosition()
    settings.set("window_x", x)
    settings.set("window_y", y)
    settings.set("window_display", display)

    Steam.shutdown()
end

function love.update(deltaTime)
    -- Update Steam integration
    if love.timer.getTime() - steamLastUpdatedAt > steamUpdateInterval then
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
    settings.set("window_width", width)
    settings.set("window_height", height)
    screenManager:emit("handleWindowResize", width, height)
end

function Steam.friends.onGameOverlayActivated(data)
    screenManager:emit("handleWindowFocus", not data.active)
end

-- Handle settings change
settings.addHandler("window_mode", function (value)
    if value == "windowed" then
        love.window.setFullscreen(false)
    elseif value == "borderless" then
        love.window.setFullscreen(true, "desktop")
    else
        love.window.setFullscreen(true, "exclusive")
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