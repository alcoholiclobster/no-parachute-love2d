local Concord = require("lib.concord")
local maf = require("lib.maf")
local assets = require("engine.assets")

local ObstacleSpawn = Concord.system({
    pool = {"lastObstacleZ", "distanceBetweenObstacles", "lastObstacleIndex"},
    cameraPool = {"camera"}
})

function ObstacleSpawn:update(deltaTime)
    local camera = self.cameraPool[1]
    if not camera then
        return
    end

    local levelGenerator = self:getWorld().gameManager.levelGenerator

    for _, e in ipairs(self.pool) do
        local distance = math.abs((camera.position.value.z - 100) - e.lastObstacleZ.value)
        if distance > e.distanceBetweenObstacles.value then
            e.lastObstacleIndex.value = e.lastObstacleIndex.value + 1
            e.lastObstacleZ.value = camera.position.value.z - 100

            local generatedObstacle = levelGenerator.obstacles[e.lastObstacleIndex.value]

            if generatedObstacle then
                local texture = assets.texture(generatedObstacle.plane.texture)
                local canvas = love.graphics.newCanvas(128, 128)
                love.graphics.setCanvas(canvas)
                love.graphics.clear()
                love.graphics.setBlendMode("alpha")
                love.graphics.setColor(1, 1, 1, 1)
                love.graphics.draw(texture, 0, 0)
                love.graphics.setCanvas()
                canvas:setFilter("nearest", "nearest")

                local obstacleEntity = Concord.entity(self:getWorld())
                    :give("position", maf.vec3(0, 0, camera.position.value.z - 100 - 0.51))
                    :give("size", maf.vec3(10, 10))
                    :give("rotation", generatedObstacle.rotation)
                    :give("drawable")
                    :give("obstaclePlane")
                    :give("destroyOutOfBounds")
                    :give("texture", canvas)
                    :give("collisionTexture", texture)

                if generatedObstacle.plane.rotationSpeed then
                    obstacleEntity:give("rotationSpeed", generatedObstacle.plane.rotationSpeed)
                end

                if generatedObstacle.plane.velocity then
                    local v = generatedObstacle.plane.velocity
                    obstacleEntity:give("velocity", maf.vec3(v[1], v[2], v[3]))
                end

                if e.lastObstacleIndex.value == #levelGenerator.obstacles then
                    obstacleEntity:give("lastObstacle")
                end
            end

            if e.lastObstacleIndex.value == #levelGenerator.obstacles then
                e:destroy()
            end
        end
    end
end

return ObstacleSpawn