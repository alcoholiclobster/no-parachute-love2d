local Concord = require("lib.concord")
local maf = require("lib.maf")

local LevelFinish = Concord.system({
    charactersPool = {"character", "position", "controlledByPlayer", "velocity", "moveDirection", "levelProgress"},
    cameraPool = {"camera"}
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

            self:getWorld().gameManager.ui.state = "finished"
        end
    end
end

return LevelFinish