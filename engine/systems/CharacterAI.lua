local Concord = require("lib.concord")
local maf = require("lib.maf")
local mathUtils = require("utils.math")

local CharacterAI = Concord.system({
    playerPool = {"position", "rotation", "controlledByPlayer", "alive"},
    pool = {"position", "rotation", "rotationSpeed", "moveDirection", "controlledByAI", "alive"}
})

local minDistanceFromPlayer = 1.5
local slowdownDistance = 5

function CharacterAI:update(deltaTime)
    local player = self.playerPool[1]
    if not player then
        return
    end

    for _, e in ipairs(self.pool) do
        local targetPosition = player.position.value
        local direction = targetPosition - e.position.value

        local targetRotation = math.atan2(direction.y, direction.x) + math.pi * 0.5
        if targetRotation > e.rotation.value then
            e.rotationSpeed.value = mathUtils.lerp(e.rotationSpeed.value, 2, deltaTime * 1)
        else
            e.rotationSpeed.value = mathUtils.lerp(e.rotationSpeed.value, -2, deltaTime * 1)
        end

        local verticalDistance = targetPosition.z - e.position.value.z
        if verticalDistance < 0 then
            e.position.value.z = e.position.value.z - deltaTime * 3
        end

        local distance = #direction

        if distance > minDistanceFromPlayer then
            direction = direction:normalize()
            if distance < slowdownDistance then
                direction = direction * (distance - minDistanceFromPlayer / (slowdownDistance - minDistanceFromPlayer))
            end
            direction = direction * 0.5

            -- Slowly approach player while moving down
            if verticalDistance < 0 then
                direction = direction * 0.1
            end

            e.moveDirection.value = mathUtils.rotateVector2D(direction, -e.rotation.value)
        else
            local ox = math.cos(love.timer.getTime() * 0.6) * 0.1
            local oy = math.sin(love.timer.getTime() * 0.6) * 0.1
            e.moveDirection.value = maf.vec3(ox, oy, 0)
        end
    end
end

return CharacterAI