local Concord = require("lib.concord")
local mathUtils = require("utils.math")
local maf = require("lib.maf")

local MenuCamera = Concord.system({
    pool = {"camera", "position"},
    cameraTargetPool = {"controlledByPlayer", "position", "alive"}
})

function MenuCamera:update(deltaTime)
    local target = self.cameraTargetPool[1]
    if not target then
        return
    end
    local time = love.timer.getTime() * 0.25
    target.position.value = maf.vec3(1.2 + math.sin(time * 1.5) * 0.4, 0, target.position.value.z)
    target.rotation.value = -0.2 + math.sin(time) * 0.1

    for _, e in ipairs(self.pool) do
        e.position.value.x = 0
        e.position.value.y = 0
        e.position.value.z = target.position.value.z + 3 + math.cos(time * 2) * 0.5
        e.rotation.value = 0.1
    end
end

return MenuCamera