local Concord = require("lib.concord")
local mathUtils = require("utils.math")

local CameraSpeedFOV = Concord.system({
    cameraPool = {"camera", "position"},
    playerPool = {"score", "velocity", "controlledByPlayer"}
})

function CameraSpeedFOV:update(deltaTime)
    local cameraEntity = self.cameraPool[1]
    if not cameraEntity then
        return
    end
    local playerCharacter = self.playerPool[1]
    if not playerCharacter then
        return
    end

    local gameManager = self:getWorld().gameManager
    local velocity = playerCharacter.velocity.value
    local velocityIncrease = mathUtils.clamp01((velocity.z / -gameManager.levelConfig.fallSpeed - 1) / 0.5)

    cameraEntity.camera.fov = 1 + velocityIncrease * 0.6
    cameraEntity.camera.followDistance = 8 - velocityIncrease * 3

    gameManager.ui:setSpeedEffectAmount(velocityIncrease)
end

return CameraSpeedFOV