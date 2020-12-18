local Concord = require("lib.concord")

local DestroyOutOfBounds = Concord.system({
    pool = {"destroyOutOfBounds", "position"},
    cameraPool = {"camera"}
})

function DestroyOutOfBounds:update()
    local camera = self.cameraPool[1]
    if not camera then
        return
    end
    for _, e in ipairs(self.pool) do
        local cameraZ = camera.position.value.z
        if e.position.value.z > cameraZ + 5 or e.position.value.z < cameraZ - 130 then
            e:destroy()
        end
    end
end

return DestroyOutOfBounds