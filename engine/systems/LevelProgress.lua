local Concord = require("lib.concord")

local LevelProgress = Concord.system({
    pool = {"character", "playerControlled", "position"}
})

function LevelProgress:update(deltaTime)
    local playerCharacter = self.pool[1]
    if not playerCharacter then
        return
    end

    local gameManager = self:getWorld().gameManager
    local progress = playerCharacter.position.value.z / (#gameManager.levelGenerator.obstacles * gameManager.levelConfig.distanceBetweenObstacles + 100 - gameManager.levelConfig.distanceBetweenObstacles)
    progress = math.min(1, math.abs(progress))

    gameManager.ui:updateLevelProgress(progress)
end

return LevelProgress