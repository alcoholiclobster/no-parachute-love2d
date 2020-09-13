local Concord = require("lib.concord")
local maf = require("lib.maf")
local mathUtils = require("utils.math")

local PlayerControl = Concord.system({
    pool = {"velocity", "playerControlled", "moveDirection"},
})

function PlayerControl:update(deltaTime)
    for _, e in ipairs(self.pool) do
        local acceleration = 15
        local friction = 7
        local speed = 10
        local direction = maf.vec3(0, 0, 0)
        if love.keyboard.isDown("left") then
            direction.x = -speed
        elseif love.keyboard.isDown("right") then
            direction.x = speed
        else
            direction.x = 0
        end

        if love.keyboard.isDown("up") then
            direction.y = -speed
        elseif love.keyboard.isDown("down") then
            direction.y = speed
        else
            direction.y = 0
        end

        e.moveDirection.value = direction
        direction = mathUtils.rotateVector2D(direction, e.rotation.value)
        local velocityZ = e.velocity.value.z
        e.velocity.value = e.velocity.value + direction * acceleration * deltaTime
        e.velocity.value = e.velocity.value - e.velocity.value * friction * deltaTime
        e.velocity.value.z = velocityZ
        e.rotation.value = e.rotation.value + deltaTime * 0.1
    end
end

return PlayerControl