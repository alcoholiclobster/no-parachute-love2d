love.errorhandler = require("utils.errorhandler")
local argparse = require("lib.argparse")
local ScreenManager = require("ui.ScreenManager")
local joystickManager = require("utils.joystickManager")
local console = require("utils.console")
local mouseUtils = require("utils.mouse")
local musicManager = require("utils.musicManager")
local scheduler = require("utils.scheduler")
local settings = require("core.settings")
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
    console.log("love.load()")

    love.filesystem.setIdentity("no_parachute")

    local steamUserId = "offline"
    if Steam.init() then
        steamUserId = tostring(Steam.user.getSteamID())
    elseif not debugNoSteam then
        error("Steam must be running")
        return
    end

    languageUtils.loadLanguage("en")
    love.window.setIcon(love.image.newImageData("assets/window_icon.png"))

    love.filesystem.createDirectory(steamUserId)
    storage.load(steamUserId.."/user_progress.bin")
    settings.load(steamUserId.."/user_settings.json")

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
    math.randomseed(os.time())

    debugSimulateFrameRate = tonumber(args.fps) or 0

    screenManager = ScreenManager:new()

    if args.level then
        print("Force loading level "..tostring(args.level))
        screenManager:transition("GameScreen", args.level)
    elseif args.screen then
        screenManager:transition(args.screen)
    else
        screenManager:transition("MainMenuScreen")
    end
    screenManager.fadeProgress = 0.5

    if args.maximize then
        love.window.maximize()
    end
end

function love.quit()
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
    elseif key == "r" and love.keyboard.isDown("ctrl") then
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