local Concord = require("lib.concord")

local LevelProgress = Concord.system({
    pool = {"character", "controlledByPlayer", "position"}
})

function LevelProgress:update(deltaTime)
    local gameManager = self:getWorld().gameManager

    for _, e in ipairs(self.pool) do
        local progress = e.position.value.z / ((#gameManager.levelGenerator.obstacles - 1) * gameManager.levelConfig.distanceBetweenObstacles + 100 + gameManager.levelConfig.distanceBetweenObstacles)
        progress = math.min(1, math.abs(progress))
        e.levelProgress.value = progress
    end

    if self.pool[1] then
        gameManager.ui:updateLevelProgress(self.pool[1].levelProgress.value)
    end
end

return LevelProgress