local Concord = require("lib.concord")
local maf = require("lib.maf")

local LevelFinish = Concord.system({
    lastObstaclePool = {"lastObstacle"},
    charactersPool = {"character", "position", "playerControlled"},
    cameraPool = {"camera"}
})

function LevelFinish:update(deltaTime)
    local lastObstacle = self.lastObstaclePool[1]
    if not lastObstacle then
        return
    end

    for _, character in ipairs(self.charactersPool) do
        if lastObstacle.position.value.z > character.position.value.z + 2 then
            character:remove("playerControlled")

            if self.cameraPool[1] then
                self.cameraPool[1]:give("velocity", maf.vec3(0, 0, character.velocity.value.z * 0.25))
            end
        end
    end
end

return LevelFinish