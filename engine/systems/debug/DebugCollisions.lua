local Concord = require("lib.concord")
local renderingUtils = require("utils.rendering")
local mathUtils = require("utils.math")

local DebugCollisions = Concord.system({
    cameraPool = {"camera"},
    entitiesWithObstacleCollisionOffset = {"obstacleCollisionCheckOffset", "name"}
})

local isObstacleCollisionsOffsetsVisible = false

function DebugCollisions:draw()
    local camera = self.cameraPool[1]
    if not camera then
        return
    end

    if isObstacleCollisionsOffsetsVisible then
        love.graphics.setColor(0, 1, 0, 1)
        for _, e in ipairs(self.entitiesWithObstacleCollisionOffset) do
            local offset = e.obstacleCollisionCheckOffset.value
            local point = e.position.value + mathUtils.rotateVector2D(offset, e.rotation.value)

            local x, y = renderingUtils.project(point, camera.position.value)
            if x then
                love.graphics.rectangle("fill", x - 2, y - 2, 4, 4)
                love.graphics.print(e.name.value, x + 6, y - 4)
            end
        end
    end
end

function DebugCollisions:keyPress(key)
    if key == "f3" then
        isObstacleCollisionsOffsetsVisible = not isObstacleCollisionsOffsetsVisible
    end
end

return DebugCollisions