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
local achievements = require("utils.achievements")

local isInitialized = false

local debugUpdateDelay = 0
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
    local success = pcall(function ()
        if GameEnv.disableSteam then
            error("Steam disabled")
        end

        local steamInitStartAt = love.timer.getTime()
        if Steam.init() then
            steamUserId = tostring(Steam.user.getSteamID())
        elseif not GameEnv.disableSteam then
            error("Steam must be running")
        end

        print("Steam initalization completed in", math.floor((love.timer.getTime() - steamInitStartAt) * 1000) / 1000, "s")
    end)

    if not success then
        if GameEnv.disableSteam then
            print("Failed to connect to steam")
        else
            love.window.showMessageBox("Steam initialization error", "Failed to connect to Steam. Make sure that Steam client is running.", "error")
            -- love.event.quit()
        end
    end

    GameEnv.isSteamInitialized = success

    -- Load game saves
    love.filesystem.createDirectory(steamUserId)
    storage.load(steamUserId.."/user_progress.bin")

    -- Init achievements
    if success then
        Steam.userStats.requestCurrentStats()
        achievements.init()
    end

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
    if GameEnv.enableCommandLineArgs then
        parser:option("--level", "Force load game level")
        parser:option("--screen", "Force display screen")
        parser:flag("--maximize", "Force maximize window")
        parser:flag("--nosplash", "Skip splash screen")
    end
    local args = parser:parse(arg)

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
        achievements.update()
    end

    -- Don't update game if it's frozen
    if deltaTime > 0.5 then
        return
    end

    scheduler.update(deltaTime)
    mouseUtils.update()
    screenManager:update(deltaTime)
    musicManager:update(deltaTime)

    if GameEnv.simulateFrameRate then
        debugUpdateDelay = debugUpdateDelay + deltaTime
        if debugUpdateDelay > 1 / GameEnv.simulateFrameRate then
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

    if key == "`" and GameEnv.enableGameConsole then
        console.toggle()
    elseif key == "f11" then
        if settings.get("window_mode") == "windowed" then
            settings.set("window_mode", "fullscreen")
        else
            settings.set("window_mode", "windowed")
        end
    end

    if GameEnv.enableDebugMode then
        if key == "r" and love.keyboard.isDown("lctrl") and love.keyboard.isDown("lshift") then
            love.event.quit("restart")
        elseif key == "k" and love.keyboard.isDown("lctrl") and love.keyboard.isDown("lshift") then
            Steam.userStats.resetAllStats(true)
            Steam.userStats.storeStats()
            print("Achievements reset")
        end
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

function Steam.userStats.onUserStatsReceived(data)
    print("Steam achievements loaded")
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

    screenManager:emit("handleWindowResize", love.graphics.getWidth(), love.graphics.getHeight())
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