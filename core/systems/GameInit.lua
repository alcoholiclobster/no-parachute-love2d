local Concord = require("lib.concord")
local mathUtils = require("utils.math")
local maf = require("lib.maf")

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
    local count = levelConfig.sidePlanesCount
    local previousDirection = -1
    for i = 0, count - 1 do
        local z = -100 + i * 100 / count
        local direction = math.random(1, 4)
        if direction == previousDirection then
            direction = direction + 1
        end
        previousDirection = direction

        Concord.entity(world)
            :give("position", maf.vec3(0, 0, z))
            :give("size", maf.vec3(10 * mathUtils.sign(math.random() - 0.5), 10 * mathUtils.sign(math.random() - 0.5)))
            :give("rotation", direction*math.pi * 0.5)
            :give("drawable")
            :give("sidePlane")
            :give("sidePlaneRespawnEvent")
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
        :give("planeSpawner")
end

return GameInit