local Concord = require("lib.concord")

local Movement = Concord.system({
    pool = {"position", "velocity"}
})

function Movement:update(deltaTime)
    for _, e in ipairs(self.pool) do
        e.position.value = e.position.value + e.velocity.value * deltaTime
    end
end

return Movement