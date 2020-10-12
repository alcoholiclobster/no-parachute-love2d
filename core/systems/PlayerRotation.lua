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
            e.rotation.value = math.sin(e.levelProgress.value * levelConfig.playerRotationChangeSpeed) * maxSpeed * math.pi * 2
        end
    end
end

return PlayerRotation