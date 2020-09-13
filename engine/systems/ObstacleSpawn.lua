local Concord = require("lib.concord")
local maf = require("lib.maf")
local Assets = require("engine.Assets")

local ObstacleSpawn = Concord.system({
    pool = {"lastObstacleDistance"},
    playerPool = {"fallSpeed", "playerControlled"}
})

function ObstacleSpawn:update(deltaTime)
    local player = self.playerPool[1]
    if not player then
        return
    end

    for _, e in ipairs(self.pool) do
        if e.lastObstacleDistance.value > 40 then
            e.lastObstacleDistance.value = 0
            Concord.entity(self:getWorld())
                :give("position", maf.vec3(0, 0, -100))
                :give("size", maf.vec3(10, 10))
                :give("rotation", math.random(1, 4)*math.pi * 0.5)
                :give("drawable")
                :give("obstaclePlane")
                :give("velocity", maf.vec3(0, 0, player.fallSpeed.value))
                :give("color", 1, 1, 1)
                :give("texture", Assets.texture("level1/obstacle"..math.random(1, 7)))
        else
            e.lastObstacleDistance.value = e.lastObstacleDistance.value + player.fallSpeed.value * deltaTime
        end
    end
end

return ObstacleSpawn