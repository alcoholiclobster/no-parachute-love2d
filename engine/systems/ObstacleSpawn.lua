local Concord = require("lib.concord")
local maf = require("lib.maf")
local Assets = require("engine.Assets")

local ObstacleSpawn = Concord.system({
    pool = {"lastObstacleZ", "distanceBetweenObstacles"},
    cameraPool = {"camera"}
})

function ObstacleSpawn:update(deltaTime)
    local camera = self.cameraPool[1]
    if not camera then
        return
    end

    for _, e in ipairs(self.pool) do
        local distance = math.abs((camera.position.value.z - 100) - e.lastObstacleZ.value)
        if distance > e.distanceBetweenObstacles.value then
            e.lastObstacleZ.value = camera.position.value.z - 100

            Concord.entity(self:getWorld())
                :give("position", maf.vec3(0, 0, camera.position.value.z - 100))
                :give("size", maf.vec3(10, 10))
                :give("rotation", math.random(1, 4)*math.pi * 0.5)
                :give("drawable")
                :give("obstaclePlane")
                :give("destroyAboveCamera")
                :give("color", 1, 1, 1)
                :give("texture", Assets.texture("level1/obstacle"..math.random(1, 7)))
        end
    end
end

return ObstacleSpawn