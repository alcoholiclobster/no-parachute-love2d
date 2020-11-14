local Concord = require("lib.concord")

local LevelProgress = Concord.system({
    pool = {"character", "controlledByPlayer", "position"}
})

function LevelProgress:update(deltaTime)
    local gameManager = self:getWorld().gameManager
    local levelHeight = gameManager.levelConfig.totalHeight

    for _, e in ipairs(self.pool) do
        local progress = e.position.value.z / levelHeight
        progress = math.min(1, math.abs(progress))
        e.levelProgress.value = progress
    end

    if self.pool[1] then
        gameManager:triggerUI("updateLevelProgress", self.pool[1].levelProgress.value)
    end
end

return LevelProgress