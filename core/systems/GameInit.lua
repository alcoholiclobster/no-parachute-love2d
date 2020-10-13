local Concord = require("lib.concord")
local mathUtils = require("utils.math")
local maf = require("lib.maf")
local assets = require("core.assets")

local GameInit = Concord.system({})

function GameInit:init()
    local world = self:getWorld()
    local levelConfig = world.gameManager.levelConfig

    levelConfig.totalHeight = 0
    for i, p in ipairs(levelConfig.planes) do
        levelConfig.totalHeight = levelConfig.totalHeight + p.distance
    end
    levelConfig.totalHeight = levelConfig.totalHeight + 70

    -- Side walls planes
    local count = math.max(27, levelConfig.sidePlanesCount)
    local prevSidePlaneDirections = {}
    for i = 0, count - 1 do
        local planeIndex = math.random(1, #levelConfig.sidePlanes)
        local decoration = levelConfig.sidePlanes[planeIndex]
        local z = -100 + i * 100 / count

        local direction = math.random(1, 4)
        if prevSidePlaneDirections[planeIndex] and prevSidePlaneDirections[planeIndex] == direction then
            direction = direction + 1
            if direction > 4 then
                direction = 1
            end
        end
        prevSidePlaneDirections[planeIndex] = direction

        Concord.entity(world)
            :give("position", maf.vec3(0, 0, z))
            :give("size", maf.vec3(10 * mathUtils.sign(math.random() - 0.5), 10 * mathUtils.sign(math.random() - 0.5)))
            :give("rotation", direction*math.pi * 0.5)
            :give("drawable")
            :give("decorativePlane")
            :give("texture", assets.texture(decoration.texture))
    end

    -- Spawn player
    Concord.entity(world)
        :give("characterSpawnRequest", "player", true)

    -- Camera
    Concord.entity(world)
        :give("position", maf.vec3(0, 0, 0))
        :give("rotation", 0)
        :give("camera")

    -- Obstacle spawner
    Concord.entity(world)
        :give("lastObstacleZ", 0)
        :give("lastObstacleIndex", 0)
end

return GameInit