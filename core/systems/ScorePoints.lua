local Concord = require("lib.concord")
local mathUtils = require("utils.math")

local ScorePoints = Concord.system({
    pool = {"score", "velocity", "controlledByPlayer", "alive"}
})

function ScorePoints:update(deltaTime)
    local gameManager = self:getWorld().gameManager
    local playerCharacter = self.pool[1]
    if not playerCharacter then
        return
    end

    local velocity = playerCharacter.velocity.value
    local velocityIncrease = mathUtils.clamp01(velocity.z / -gameManager.levelConfig.fallSpeed - 1)
    local scoreIncrease = 100 * (1 + velocityIncrease * 2) * deltaTime
    if velocity.z > -gameManager.levelConfig.fallSpeed + 1 then
        scoreIncrease = 5000 * (velocity.z / -gameManager.levelConfig.fallSpeed - 1) * deltaTime
    end

    playerCharacter.score.value = playerCharacter.score.value + scoreIncrease

    gameManager:triggerUI("updateScore", playerCharacter.score.value)
    gameManager:triggerUI("updateSpeed", playerCharacter.velocity.value.z + math.sin(love.timer.getTime() * 0.4) * 0.1)
end

return ScorePoints