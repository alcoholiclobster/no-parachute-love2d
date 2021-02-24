local Concord = require("lib.concord")
local assets = require("core.assets")

local ObstaclePassPlayer = Concord.system({
    characterPool = {"controlledByPlayer", "position"},
    obstaclePool = {"position", "obstaclePlane", "obstacleNotAbovePlayer"}
})

function ObstaclePassPlayer:update(deltaTime)
    local character = self.characterPool[1]
    if character then
        for _, e in ipairs(self.obstaclePool) do
            if e.position.value.z > character.position.value.z then
                e:remove("obstacleNotAbovePlayer")
                e:give("obstaclePassedPlayerEvent")
            end
        end
    end
end

return ObstaclePassPlayer