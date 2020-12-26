local Concord = require("lib.concord")
local settings = require "core.settings"

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
        if math.abs(e.position.value.z - camera.position.value.z) < 15 and e.bloodSpawnEvent.level > 1 then
            for i = 1, math.random(5, 10) * e.bloodSpawnEvent.level * settings.get("particles_quality") do
                local s = math.floor(screenHeight/128*math.random(1, 4))
                Concord.entity(self:getWorld())
                    :give("position2d", screenWidth * math.random(), screenHeight * math.random())
                    :give("size2d", s, s)
                    :give("lifeTime", 1 + math.random())
                    :give("color", 0.4 + math.random() * 0.3, 0, 0, 0.2 + math.random() * 0.4)
            end
        end
    end
end

return BloodCameraCollision