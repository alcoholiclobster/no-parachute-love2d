local Concord = require("lib.concord")

local DelayedVelocity = Concord.system({
    pool = {"delayedVelocity"}
})

function DelayedVelocity:update(deltaTime)
    for _, e in ipairs(self.pool) do
        e.delayedVelocity.time = e.delayedVelocity.time - deltaTime
        if e.delayedVelocity.time < 0 then
            e:give("velocity", e.delayedVelocity.velocity)
            e:remove("delayedVelocity")
        end
    end
end

return DelayedVelocity