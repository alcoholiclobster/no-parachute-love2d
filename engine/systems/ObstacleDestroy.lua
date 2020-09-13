local Concord = require("lib.concord")

local ObstacleDestroy = Concord.system({
    pool = {"obstaclePlane", "position"},
    cameraPool = {"camera"}
})

function ObstacleDestroy:update(deltaTime)
    local camera = self.cameraPool[1]
    if not camera then
        return
    end
    for _, e in ipairs(self.pool) do
        if e.position.value.z > camera.position.value.z then
            e:destroy()
        end
    end
end

return ObstacleDestroy