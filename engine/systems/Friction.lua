local Concord = require("lib.concord")

local Friction = Concord.system({
    pool = {"friction", "velocity"}
})

function Friction:update(deltaTime)
    for _, e in ipairs(self.pool) do
        local vz = e.velocity.value.z
        e.velocity.value = e.velocity.value - e.velocity.value * e.friction.value * deltaTime
        e.velocity.value.z = vz
    end
end

return Friction