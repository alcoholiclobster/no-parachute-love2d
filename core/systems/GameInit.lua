local Concord = require("lib.concord")
local mathUtils = require("utils.math")
local maf = require("lib.maf")
local settings = require("utils.settings")
local musicManager = require("utils.musicManager")

local GameInit = Concord.system({})

function GameInit:init()
    local world = self:getWorld()
    local levelConfig = world.gameManager.levelConfig

    if levelConfig.randomize then
        levelConfig.randomize(GameEnv.endlessForceSeed)
    end

    if not levelConfig.totalHeight then
        levelConfig.totalHeight = 0

        for i, p in ipairs(levelConfig.planes) do
            levelConfig.totalHeight = levelConfig.totalHeight + p.distance
        end
        levelConfig.totalHeight = levelConfig.totalHeight + 70
    end

    -- Side walls planes
    local count = math.max(30, math.floor(levelConfig.sidePlanesCount * settings.get("world_quality")))
    local previousDirection = -1
    for i = 0, count - 1 do
        local z = -100 + i * 100 / count
        local direction = math.random(1, 4)
        if direction == previousDirection then
            direction = direction + 1
        end
        previousDirection = direction

        local brightness = 1
        if levelConfig.sidePlanesRandomBrightness then
            brightness = 0.7 + math.random(1, 3) * 0.1
        end

        if levelConfig.sidePlanesBrightness then
            brightness = brightness * levelConfig.sidePlanesBrightness
        end

        brightness = mathUtils.clamp01(brightness)

        Concord.entity(world)
            :give("position", maf.vec3(0, 0, z + 0.05))
            :give("size", maf.vec3(10 * mathUtils.sign(math.random() - 0.5), 10 * mathUtils.sign(math.random() - 0.5)))
            :give("rotation", direction*math.pi * 0.5)
            :give("drawable")
            :give("sidePlane", i)
            :give("sidePlaneRespawnEvent")
            :give("color", brightness, brightness, brightness, 1)
    end

    -- Spawn player
    local playerSpawnRequest = Concord.entity(world)
        :give("characterSpawnRequest", GameEnv.hidePlayerCharacter and "player_transparent" or "player", true)

    local distance = 0
    for _, p in ipairs(levelConfig.planes) do
        if p.distance then
            distance = distance + p.distance
        end
        if p.debugSpawnHere then
            playerSpawnRequest:give("position", maf.vec3(0, 0, -distance))
            break
        end
    end

    -- Camera
    local fogColor = levelConfig.fogColor or {0, 0, 0}
    fogColor = {fogColor[1] / 255, fogColor[2] / 255, fogColor[3] / 255, 1}
    Concord.entity(world)
        :give("position", maf.vec3(0, 0, 0))
        :give("rotation", 0)
        :give("camera", fogColor)

    local gameStateEntity = Concord.entity(world)
        :give("gameState", levelConfig.fallSpeed)
    world.gameState = gameStateEntity.gameState

    if not world.isMenuBackground then
        if levelConfig.music then
            musicManager:play(levelConfig.music)
        else
            musicManager:stop()
        end
    end
end

return GameInit