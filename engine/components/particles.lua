local Concord = require("lib.concord")

Concord.component("particle")

Concord.component("particleEmitDelay", function(component, value)
    component.time = 0
    component.delay = value or 1
end)

Concord.component("particleEmitCount", function(component, min, max)
    component.min = min or 1
    component.max = max or min
end)

Concord.component("particleColor", function(component, r, g, b, a)
    component.r = r or 0
    component.g = g or 0
    component.b = b or 0
    component.a = a or 1
end)

Concord.component("particleRandomRotation")

Concord.component("particleLifeTime", function(component, min, max)
    component.min = min or 1
    component.max = max or min
end)

Concord.component("particleSpeed", function(component, minX, maxX, minY, maxY, minZ, maxZ)
    component.minX = minX or 1
    component.maxX = maxX or minX

    component.minY = minY or 1
    component.maxY = maxY or minY

    component.minZ = minZ or 1
    component.maxZ = maxZ or minZ
end)

Concord.component("particleSize", function(component, min, max)
    component.min = min or 1
    component.max = max or min
end)

Concord.component("particleFriction", function(component, min, max)
    component.min = min or 1
    component.max = max or min
end)

Concord.component("particleGravity", function(component, gravity)
    component.value = gravity
end)