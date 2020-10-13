local Concord = require("lib.concord")

local Damage = Concord.system({
    pool = {"damageEvent", "health", "alive"}
})

function Damage:update(deltaTime)
    for _, e in ipairs(self.pool) do
        e.health.value = e.health.value - e.damageEvent.damage

        if e.health.value <= 0 then
            e:give("deathEvent")
        end
    end
end

return Damage