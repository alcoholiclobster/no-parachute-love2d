local Concord = require("lib.concord")
local mathUtils = require("utils.math")
local settings = require("utils.settings")

local CameraSpeedFOV = Concord.system({
    cameraPool = {"camera", "position"},
    playerPool = {"score", "velocity", "controlledByPlayer"},
    gameStatePool = {"gameState"},
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

    local velocity = playerCharacter.velocity.value
    local velocityIncrease = mathUtils.clamp01((velocity.z / playerCharacter.character.fallSpeed - 1) / 0.5)

    cameraEntity.camera.fov = 1 + velocityIncrease * 0.6
    cameraEntity.camera.followDistance = cameraEntity.camera.distanceFromPlayer - velocityIncrease * 2

    local world = self:getWorld()
    local gameManager = world.gameManager
    gameManager:triggerUI("setSpeedEffectAmount", velocityIncrease)
end

return CameraSpeedFOV