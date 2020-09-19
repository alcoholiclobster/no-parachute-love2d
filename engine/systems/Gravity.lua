local Concord = require("lib.concord")

local Gravity = Concord.system({
    pool = {"gravity", "velocity"}
})

function Gravity:update(deltaTime)
    for _, e in ipairs(self.pool) do
        e.velocity.value = e.velocity.value + e.gravity.value * deltaTime
    end
end

return Gravity