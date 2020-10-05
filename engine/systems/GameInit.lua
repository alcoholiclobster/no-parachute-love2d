local Concord = require("lib.concord")
local mathUtils = require("utils.math")
local maf = require("lib.maf")
local assets = require("engine.assets")

local GameInit = Concord.system({})

function GameInit:init()
    local world = self:getWorld()
    local levelConfig = world.gameManager.levelConfig

    -- Side wall planes
    assert(levelConfig.decorations, "Invalid decorations config")
    assert(#levelConfig.decorations > 0, "Empty decorations table")
    assert(type(levelConfig.decorationPlanesCount) == "number", "Invalid decoration planes count")

    local count = math.max(27, levelConfig.decorationPlanesCount)
    for i = 0, count - 1 do
        local decoration = levelConfig.decorations[math.random(1, #levelConfig.decorations)]
        local z = -100 + i * 100 / count
        Concord.entity(world)
            :give("position", maf.vec3(0, 0, z))
            :give("size", maf.vec3(10 * mathUtils.sign(math.random() - 0.5), 10 * mathUtils.sign(math.random() - 0.5)))
            :give("rotation", math.random(1, 4)*math.pi * 0.5)
            :give("drawable")
            :give("decorativePlane")
            :give("texture", assets.texture(decoration.texture))
    end

    Concord.entity(world)
        :give("characterSpawnRequest", "player", true)

    -- Camera
    Concord.entity(world)
        :give("position", maf.vec3(0, 0, 0))
        :give("rotation", 0)
        :give("camera")

    -- Obstacle spawner
    assert(type(levelConfig.distanceBetweenObstacles) == "number", "Invalid distanceBetweenObstacles")
    Concord.entity(world)
        :give("lastObstacleZ", 0)
        :give("lastObstacleIndex", 0)
        :give("distanceBetweenObstacles", levelConfig.distanceBetweenObstacles)
end

return GameInit