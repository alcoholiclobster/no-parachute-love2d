local Concord = require("lib.concord")
local maf = require("lib.maf")

Concord.component("position", function(component, position)
    component.value = position or maf.vec3(0, 0, 0)
end)

Concord.component("size", function(component, size)
    component.value = size or maf.vec3(0, 0, 0)
end)

Concord.component("rotation", function(component, rotation)
    component.value = rotation or 0
end)

Concord.component("fillMode", function(component, mode)
    component.value = mode or "line"
end)

Concord.component("texture", function(component, texture)
    component.value = texture
    component.width = texture:getWidth()
    component.height = texture:getHeight()
end)

Concord.component("color", function(component, r, g, b, a)
    component.r = r or 0
    component.g = g or 0
    component.b = b or 0
    component.a = a or 1
end)

Concord.component("planeSideFill", function(component, width, r, g, b, a)
    component.width = width or 1
    component.r = r or 0
    component.g = g or 0
    component.b = b or 0
    component.a = a or 1
end)

Concord.component("velocity", function(component, velocity)
    component.value = velocity or maf.vec3(0, 0, 0)
end)

Concord.component("moveDirection", function(component, value)
    component.value = value or maf.vec3(0, 0, 0)
end)

Concord.component("limbParent", function(component, entity)
    component.value = entity
end)

Concord.component("limbRotation", function(component, value)
    component.value = value
end)

Concord.component("limbRotationPoses", function(component, left, right, up, down)
    component.left = left or 0
    component.right = right or 0
    component.up = up or 0
    component.down = down or 0
end)

Concord.component("offset", function(component, offset)
    component.value = offset
end)