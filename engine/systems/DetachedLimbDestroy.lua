local Concord = require("lib.concord")

local DetachedLimbDestroy = Concord.system({
    cameraPool = {"camera"},
    limbsPool = {"limbRotation", "position"}
})

function DetachedLimbDestroy:update(deltaTime)
    local camera = self.cameraPool[1]
    if not camera then
        return
    end

    for _, e in ipairs(self.limbsPool) do
        if e.position.value.z > camera.position.value.z then
            e:destroy()
        end
    end
end

return DetachedLimbDestroy