local Concord = require("lib.concord")
local mathUtils = require("utils.math")

local CameraFollowPlayer = Concord.system({
    pool = {"camera", "position"},
    cameraTargetPool = {"controlledByPlayer", "position", "alive"}
})

function CameraFollowPlayer:update(deltaTime)
    local target = self.cameraTargetPool[1]
    if not target then
        return
    end

    for _, e in ipairs(self.pool) do
        local t = love.timer.getTime() * 1.2
        e.position.value.x = mathUtils.lerp(0, target.position.value.x + math.cos(t) * 0.1, 0.8)
        e.position.value.y = mathUtils.lerp(0, target.position.value.y + math.sin(t) * 0.12, 0.8)
        e.position.value.z = target.position.value.z + e.camera.followDistance + math.cos(t) * 0.15
        e.rotation.value = -target.rotation.value
    end
end

return CameraFollowPlayer