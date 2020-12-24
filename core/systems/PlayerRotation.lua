local Concord = require("lib.concord")

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
            e.rotation.value = (e.position.value.z + 10) * maxSpeed * 0.001
        elseif levelConfig.playerRotationMode == "sinusoid" then
            local t = (e.position.value.z + 10) * levelConfig.playerRotationChangeSpeed
            e.rotation.value = math.cos(t) * maxSpeed * math.pi * 2
        end
    end
end

return PlayerRotation