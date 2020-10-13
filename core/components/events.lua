local Concord = require("lib.concord")

Concord.component("obstacleCollisionEvent", function(component, entity, hitPosition, textureX, textureY)
    component.value = entity
    component.hitPosition = hitPosition
    component.textureX = textureX
    component.textureY = textureY
end)

Concord.component("characterSpawnRequest", function(component, characterType, controlledByPlayer)
    component.characterType = characterType or "player"
    component.controlledByPlayer = not not controlledByPlayer
end)

Concord.component("damageEvent", function(component, damage)
    component.damage = damage or 0
end)

Concord.component("deathEvent")