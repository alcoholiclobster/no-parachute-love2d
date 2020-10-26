local Concord = require("lib.concord")
local renderingUtils = require("utils.rendering")
local mathUtils = require("utils.math")
local maf = require("lib.maf")

local DebugSpeed = Concord.system({
    cameraPool = {"camera"},
    pool = {"velocity", "position", "name"}
})

local isVisible = false

function DebugSpeed:draw()
    local camera = self.cameraPool[1]
    if not camera then
        return
    end

    if isVisible then
        love.graphics.setColor(0, 1, 0, 1)
        for _, e in ipairs(self.pool) do
            local offset = maf.vec3(0, 0, 0)
            local point = e.position.value + mathUtils.rotateVector2D(offset, e.rotation.value)

            local x, y, scale = renderingUtils.project(point, camera.position.value, camera.camera.fov)
            if x then
                local horizontalSpeed = #maf.vec3(e.velocity.value.x, e.velocity.value.y, 0)
                if not e.velocity.max or e.velocity.max < horizontalSpeed then
                    e.velocity.max = horizontalSpeed
                end
                love.graphics.push()
                love.graphics.scale(scale * 0.01)
                love.graphics.print("max speed: "..tostring(e.velocity.max), x + 6, y - 4)
                love.graphics.pop()
            end
        end
    end
end

function DebugSpeed:keyPress(key)
    if key == "f5" then
        isVisible = not isVisible
    end
end

return DebugSpeed