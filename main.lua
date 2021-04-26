love.errorhandler = require("utils.errorhandler")
local ScreenManager = require("ui.ScreenManager")
local joystickManager = require("utils.joystickManager")
local console = require("utils.console")
local mouseUtils = require("utils.mouse")
local musicManager = require("utils.musicManager")
local scheduler = require("utils.scheduler")
local settings = require("utils.settings")
local languageUtils = require("utils.language")
local Steam = {}
local storage = require("utils.storage")
local achievements = require("utils.achievements")

local isInitialized = false

local debugUpdateDelay = 0
local steamUpdateInterval = 0.1
local steamLastUpdatedAt = love.timer.getTime()

local screenManager

love.audio.newSource = function ()
    return {
        play = function () end,
        stop = function () end,
        setVolume = function () end,
        setLooping = function () end,
        setEffect = function () end,
        isPlaying = function () return false end,
        setPitch = function () end,
    }
end

---------------------
-- Local functions --
---------------------

local function completeInitialization()
    if isInitialized then
        return
    end

    local steamUserId = "local"

    love.filesystem.createDirectory(steamUserId)
    storage.load(steamUserId.."/user_progress.bin")

    screenManager:emit("handleInitializationFinish")
    isInitialized = true
end

----------------------
-- Love2d callbacks --
----------------------

function love.load(arg)
    GameEnv.unlockLevels = true
    console.overridePrint()
    print("Game started")

    -- Lua initialization
    math.randomseed(os.time())

    -- Initalize UI and show first screen
    screenManager = ScreenManager:new()
    screenManager:show("SplashScreen")
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

    -- Update Steam integration
    if isInitialized and love.timer.getTime() - steamLastUpdatedAt > steamUpdateInterval then
        steamLastUpdatedAt = love.timer.getTime()
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
    screenManager:emit("handleWindowResize", width, height)
end

---------------------
-- Steam callbacks --
---------------------

-----------------------
-- Settings handlers --
-----------------------