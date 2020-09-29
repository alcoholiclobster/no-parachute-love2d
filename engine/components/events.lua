local Concord = require("lib.concord")

Concord.component("obstacleCollisionEvent", function(component, entity, hitPosition, textureX, textureY)
    component.value = entity
    component.hitPosition = hitPosition
    component.textureX = textureX
    component.textureY = textureY
end)