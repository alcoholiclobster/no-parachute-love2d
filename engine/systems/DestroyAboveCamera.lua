local Concord = require("lib.concord")

local DestroyAboveCamera = Concord.system({
    pool = {"destroyAboveCamera", "position"},
    cameraPool = {"camera"}
})

function DestroyAboveCamera:update()
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

return DestroyAboveCamera