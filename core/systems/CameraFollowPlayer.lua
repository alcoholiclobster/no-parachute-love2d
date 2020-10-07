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
        e.position.value.x = mathUtils.lerp(0, target.position.value.x, 0.8)
        e.position.value.y = mathUtils.lerp(0, target.position.value.y, 0.8)
        e.position.value.z = target.position.value.z + 10
        e.rotation.value = -target.rotation.value
    end
end

return CameraFollowPlayer