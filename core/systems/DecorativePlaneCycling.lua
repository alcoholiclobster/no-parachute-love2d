local Concord = require("lib.concord")

local DecorativePlaneCycling = Concord.system({
    pool = {"position", "decorativePlane"},
    cameraPool = {"camera"}
})

function DecorativePlaneCycling:update(deltaTime)
    local camera = self.cameraPool[1]
    if not camera then
        return
    end

    for _, e in ipairs(self.pool) do
        if e.position.value.z > camera.position.value.z then
            e.position.value.z = e.position.value.z - 100
        end
    end
end

return DecorativePlaneCycling