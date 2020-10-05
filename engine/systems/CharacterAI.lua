local Concord = require("lib.concord")
local maf = require("lib.maf")
local mathUtils = require("utils.math")

local CharacterAI = Concord.system({
    playerPool = {"position", "rotation", "controlledByPlayer", "alive"},
    pool = {"position", "rotation", "moveDirection", "controlledByAI"}
})

local minDistanceFromPlayer = 1.5
local slowdownDistance = 5

function CharacterAI:update(deltaTime)
    local player = self.playerPool[1]
    if not player then
        return
    end

    for _, e in ipairs(self.pool) do
        -- e.rotation.value = player.rotation.value

        local targetPosition = player.position.value
        local direction = targetPosition - e.position.value
        local distance = #direction

        local targetRotation = math.atan2(direction.y, direction.x) + math.pi * 0.5
        e.rotation.value = mathUtils.lerp(e.rotation.value, targetRotation, deltaTime * 1)

        if distance > minDistanceFromPlayer then
            direction = direction:normalize()
            if distance < slowdownDistance then
                direction = direction * (distance - minDistanceFromPlayer / (slowdownDistance - minDistanceFromPlayer))
            end
            direction = direction * 0.5
            e.moveDirection.value = mathUtils.rotateVector2D(direction, -e.rotation.value)
        else
            local ox = math.cos(love.timer.getTime() * 0.6) * 0.1
            local oy = math.sin(love.timer.getTime() * 0.6) * 0.1
            e.moveDirection.value = maf.vec3(ox, oy, 0)
        end
    end
end

return CharacterAI