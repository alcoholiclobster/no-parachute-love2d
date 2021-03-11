local Concord = require("lib.concord")
local maf = require("lib.maf")
local storage = require("utils.storage")

local LevelFinish = Concord.system({
    charactersPool = {"character", "position", "controlledByPlayer", "velocity", "moveDirection", "levelProgress", "score"},
    cameraPool = {"camera"},
    gameStatePool = {"gameState"},
})

function LevelFinish:update(deltaTime)
    for _, character in ipairs(self.charactersPool) do
        if character.levelProgress.value >= 1 then
            character:remove("controlledByPlayer")
            character.velocity.value = maf.vec3(0, 0, character.velocity.value.z * 0.5)
            character.moveDirection.value = maf.vec3(0, 0, 0)

            if self.cameraPool[1] then
                self.cameraPool[1]:give("velocity", maf.vec3(0, 0, character.velocity.value.z * 0.9))
            end

            local levelName = self:getWorld().gameManager.ui.levelName
            storage.setLevelData(levelName, "is_completed", true)

            -- Update highscore
            local savedHighscore = storage.getLevelData(levelName, "highscore", 0)
            local newScore = math.floor(character.score.value)
            if newScore > savedHighscore then
                storage.setLevelData(levelName, "highscore", newScore)
            end

            -- Update best time
            local isNewBestTime = false
            local bestTime = storage.getLevelData(levelName, "best_time", 0)
            local timePassed = self.gameStatePool[1].gameState.timePassed
            if bestTime == 0 or timePassed < bestTime then
                isNewBestTime = true
                storage.setLevelData(levelName, "best_time", timePassed)
            end

            self:getWorld().gameManager:triggerUI("showFinishedScreen", self.gameStatePool[1].gameState.timePassed, newScore, newScore > savedHighscore, isNewBestTime)
        end
    end
end

return LevelFinish