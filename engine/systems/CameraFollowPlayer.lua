local Concord = require("lib.concord")
local mathUtils = require("utils.math")

local CameraFollowPlayer = Concord.system({
    pool = {"position", "camera"},
    playerPool = {"position", "playerControlled"}
})

function CameraFollowPlayer:update(deltaTime)
    local player = self.playerPool[1]
    if not player then
        return
    end

    for _, e in ipairs(self.pool) do
        e.position.value.x = mathUtils.lerp(0, player.position.value.x, 0.8)
        e.position.value.y = mathUtils.lerp(0, player.position.value.y, 0.8)
        e.position.value.z = player.position.value.z + 10
        e.rotation.value = -player.rotation.value
    end
end

return CameraFollowPlayer