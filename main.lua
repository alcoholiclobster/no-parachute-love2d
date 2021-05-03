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
local storage = require("utils.storage")
local achievements = require("utils.achievements")

local isInitialized = false

local debugUpdateDelay = 0

local screenManager

---------------------
-- Local functions --
---------------------

local function completeInitialization()
    if isInitialized then
        return
    end

    local user = "local"
    -- Load game saves
    love.filesystem.createDirectory(user)
    storage.load(user.."/user_progress.bin")
    GameEnv.disableSteam = true
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
        completeInitialization()
        screenManager:transition("MainMenuScreen")
    end
end

function love.quit()
    local x, y, display = love.window.getPosition()
    settings.set("window_x", math.max(1, x))
    settings.set("window_y", math.max(1, y))
    settings.set("window_display", display)
end

function love.update(deltaTime)
    if not isInitialized and screenManager.fadeProgress < 0.01 then
        completeInitialization()
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
        love.window.setFullscreen(not love.window.getFullscreen(), "exclusive")
    elseif GameEnv.enableDebugMode and key == "r" and love.keyboard.isDown("lctrl") and love.keyboard.isDown("lshift") then
        love.event.quit("restart")
    elseif GameEnv.enableDebugMode and key == "k" and love.keyboard.isDown("lctrl") and love.keyboard.isDown("lshift") then
        print("Achievements reset")
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