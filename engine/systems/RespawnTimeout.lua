local Concord = require("lib.concord")

local RespawnTimeout = Concord.system({
    pool = {"respawnTimeout"}
})

function RespawnTimeout:update(deltaTime)
    for _, e in ipairs(self.pool) do
        e.respawnTimeout.value = e.respawnTimeout.value - deltaTime
        if e.respawnTimeout.value < 0 then
            e:give("respawn")
            e:remove("respawnTimeout")
        end
    end
end

return RespawnTimeout