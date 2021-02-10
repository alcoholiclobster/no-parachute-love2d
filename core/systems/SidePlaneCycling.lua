local Concord = require("lib.concord")

local SidePlaneCycling = Concord.system({
    pool = {"position", "sidePlane"},
    tunnelEndPool = {"position", "tunnelEnd", "rotation"},
    cameraPool = {"camera"}
})

function SidePlaneCycling:update(deltaTime)
    local camera = self.cameraPool[1]
    if not camera then
        return
    end
    local tunnelEnd = self.tunnelEndPool[1]

    for _, e in ipairs(self.pool) do
        if e.position.value.z > camera.position.value.z then
            e.position.value.z = e.position.value.z - 100
            if tunnelEnd then
                e.position.value.x = tunnelEnd.position.value.x
                e.position.value.y = tunnelEnd.position.value.y
                e.rotation.value = tunnelEnd.rotation.value + math.random(1, 4) * math.pi * 0.5
            end
            e:give("sidePlaneRespawnEvent")
        end
    end
end

return SidePlaneCycling