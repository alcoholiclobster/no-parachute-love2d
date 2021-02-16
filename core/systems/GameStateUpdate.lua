local Concord = require("lib.concord")

local GameStateUpdate = Concord.system({
    pool = {"gameState"}
})

function GameStateUpdate:update(deltaTime)
    for _, e in ipairs(self.pool) do
        e.gameState.timePassed = e.gameState.timePassed + deltaTime
    end
end

return GameStateUpdate