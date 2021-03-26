local Concord = require("lib.concord")
local gameConfig = require("config.game")

local ScorePoints = Concord.system({
    pool = {"score", "velocity", "controlledByPlayer", "alive"}
})

function ScorePoints:update(deltaTime)
    local world = self:getWorld()
    local gameManager = world.gameManager
    local fallSpeed = world.gameState.fallSpeed
    local playerCharacter = self.pool[1]
    if not playerCharacter then
        return
    end

    local speed = playerCharacter.velocity.value.z
    local speedMultiplier = 1
    if -speed > fallSpeed then
        speedMultiplier = 1 + ((-speed) / fallSpeed - 1) * gameConfig.additionalSpeedMultiplier
    elseif -speed < fallSpeed then
        speedMultiplier = -speed / fallSpeed
    end
    local score = gameConfig.scorePerSecond * speedMultiplier

    playerCharacter.score.value = playerCharacter.score.value + score * deltaTime

    gameManager:triggerUI("updateScore", playerCharacter.score.value)
    gameManager:triggerUI("updateSpeed", speed + math.sin(love.timer.getTime() * 0.4) * 0.1)
end

return ScorePoints