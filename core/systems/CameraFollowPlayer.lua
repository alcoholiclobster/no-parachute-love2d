local Concord = require("lib.concord")
local mathUtils = require("utils.math")
local maf = require("lib.maf")

local CameraFollowPlayer = Concord.system({
    pool = {"camera", "position"},
    cameraTargetPool = {"controlledByPlayer", "position", "alive"},
    tunnelCenterPool = {"position", "tunnelCenter"},
})

function CameraFollowPlayer:update(deltaTime)
    local target = self.cameraTargetPool[1]
    if not target then
        return
    end
    local centerPos = maf.vec3(0, 0, 0)
    if self.tunnelCenterPool[1] then
        centerPos = self.tunnelCenterPool[1].position.value
    end

    for _, e in ipairs(self.pool) do
        local t = love.timer.getTime() * 1.2
        e.position.value.x = mathUtils.lerp(centerPos.x, target.position.value.x + math.cos(t) * 0.1, 0.8)
        e.position.value.y = mathUtils.lerp(centerPos.y, target.position.value.y + math.sin(t) * 0.12, 0.8)
        e.position.value.z = target.position.value.z + e.camera.followDistance + math.cos(t) * 0.15
        e.rotation.value = -target.rotation.value
    end
end

return CameraFollowPlayer