local Concord = require("lib.concord")
local mathUtils = require("utils.math")

local PlayerRotation = Concord.system({
    playerCharactersPool = {"controlledByPlayer", "position", "alive", "rotation", "levelProgress"}
})

function PlayerRotation:update(deltaTime)
    local levelConfig = self:getWorld().gameManager.levelConfig
    for _, e in ipairs(self.playerCharactersPool) do
        local maxSpeed = levelConfig.playerRotationSpeed
        if levelConfig.playerRotationSpeedDependsOnProgress then
            maxSpeed = maxSpeed * e.levelProgress.value
        end

        if levelConfig.playerRotationMode == "constant" then
            e.rotation.value = e.rotation.value + maxSpeed * deltaTime
        elseif levelConfig.playerRotationMode == "sinusoid" then
            local speed = math.sin(love.timer.getTime() * levelConfig.playerRotationChangeSpeed) * maxSpeed
            e.rotation.value = e.rotation.value + speed * deltaTime
        end
    end
end

return PlayerRotation