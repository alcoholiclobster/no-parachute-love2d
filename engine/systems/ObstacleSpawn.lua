local Concord = require("lib.concord")
local maf = require("lib.maf")
local assets = require("engine.assets")

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

            local texture = assets.texture("level1/obstacle"..math.random(1, 7))
            local canvas = love.graphics.newCanvas(128, 128)
            love.graphics.setCanvas(canvas)
            love.graphics.clear()
            love.graphics.setBlendMode("alpha")
            love.graphics.draw(texture, 0, 0)
            love.graphics.setCanvas()
            canvas:setFilter("nearest", "nearest")

            Concord.entity(self:getWorld())
                :give("position", maf.vec3(0, 0, camera.position.value.z - 100))
                :give("size", maf.vec3(10, 10))
                :give("rotation", math.random(1, 4)*math.pi * 0.5)
                :give("drawable")
                :give("obstaclePlane")
                :give("destroyAboveCamera")
                :give("color", 1, 1, 1)
                :give("texture", canvas)
                :give("collisionTexture", texture)
                :give("velocity", maf.vec3(2, 0, 0))
                :give("rotationSpeed", 0.5)
        end
    end
end

return ObstacleSpawn