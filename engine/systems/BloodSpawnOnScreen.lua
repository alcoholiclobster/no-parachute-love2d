local Concord = require("lib.concord")
local renderingUtils = require("utils.rendering")

local BloodCameraCollision = Concord.system({
    pool = {"position", "bloodSpawnEvent"},
    cameraPool = {"camera"}
})

function BloodCameraCollision:update(deltaTime)
    local camera = self.cameraPool[1]
    if not camera then
        return
    end

    local screenWidth, screenHeight = love.graphics.getWidth(), love.graphics.getHeight()
    for _, e in ipairs(self.pool) do
        Concord.entity(self:getWorld())
            :give("position2d", screenWidth * math.random(), screenHeight * math.random())
            :give("size2d", 150, 150)
            :give("lifeTime", 1)
            :give("color", 1, 0, 0, 1)
    end
end

return BloodCameraCollision