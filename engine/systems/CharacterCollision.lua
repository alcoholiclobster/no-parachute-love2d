local Concord = require("lib.concord")

local CharacterCollision = Concord.system({
    pool = {"character", "position", "size", "velocity"}
})

local maxCollisionForce = 100
local maxVerticalDistance = 1

function CharacterCollision:update(deltaTime)
    for _, e1 in ipairs(self.pool) do
        for _, e2 in ipairs(self.pool) do
            if e1 ~= e2 then
                local direction = e2.position.value - e1.position.value
                local distance = #direction
                local minDistance = (e1.size.value.x + e2.size.value.x) * 0.2
                local verticalDistance = math.abs(e1.position.value.z - e2.position.value.z)
                if distance < minDistance and verticalDistance < maxVerticalDistance then
                    local moveDirection = -direction:normalize() * (1 - distance / minDistance) * maxCollisionForce
                    moveDirection.z = 0
                    moveDirection = moveDirection * (1 - (verticalDistance / maxVerticalDistance))
                    e1.velocity.value = e1.velocity.value + moveDirection * deltaTime
                end
            end
        end
    end
end

return CharacterCollision