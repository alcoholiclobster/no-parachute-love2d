local Concord = require("lib.concord")

local Damage = Concord.system({
    damagePool = {"damageEvent", "health", "alive"},
    damageCooldownPool = {"damageCooldown"},
})

function Damage:update(deltaTime)
    for _, e in ipairs(self.damagePool) do
        if not e.damageCooldown then
            e.health.value = e.health.value - e.damageEvent.damage

            if e.health.value <= 0 then
                e:give("deathEvent")
            end
        end
    end

    for _, e in ipairs(self.damageCooldownPool) do
        e.damageCooldown.time = e.damageCooldown.time - deltaTime

        if e.damageCooldown.time < 0 then
            e:remove("damageCooldown")
        end
    end
end

return Damage