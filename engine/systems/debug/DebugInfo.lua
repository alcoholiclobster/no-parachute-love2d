local Concord = require("lib.concord")

local DebugInfo = Concord.system({
    decorativePool = {"decorativePlane"},
    obstaclePool = {"obstaclePlane"},
    playerPool = {"playerControlled"},
})

function DebugInfo:draw()
    love.graphics.origin()
    love.graphics.setColor(0, 1, 0, 1)
    local y = 10
    love.graphics.print("FPS: "..tostring(love.timer.getFPS()), 10, y)
    y = y + 18
    love.graphics.print("Entities count: "..tostring(#self:getWorld():getEntities()), 10, y)
    y = y + 18
    love.graphics.print("Decorative planes: "..tostring(#self.decorativePool), 10, y)
    y = y + 18
    love.graphics.print("Obstacle planes: "..tostring(#self.obstaclePool), 10, y)
    y = y + 18
    love.graphics.print("Player Z: "..tostring(math.floor(self.playerPool[1].position.value.z)), 10, y)
end

return DebugInfo