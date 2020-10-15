local Concord = require("lib.concord")

local SidePlaneCycling = Concord.system({
    pool = {"position", "sidePlane"},
    cameraPool = {"camera"}
})

function SidePlaneCycling:update(deltaTime)
    local camera = self.cameraPool[1]
    if not camera then
        return
    end

    for _, e in ipairs(self.pool) do
        if e.position.value.z > camera.position.value.z then
            e.position.value.z = e.position.value.z - 100
            e:give("sidePlaneRespawnEvent")
        end
    end
end

return SidePlaneCycling