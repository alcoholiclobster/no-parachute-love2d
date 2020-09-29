local Concord = require("lib.concord")

local EventCleanup = Concord.system({
    obstacleCollisionEventPool = {"obstacleCollisionEvent"}
})

function EventCleanup:update(deltaTime)
    for _, e in ipairs(self.obstacleCollisionEventPool) do
        e:remove("obstacleCollisionEvent")
    end
end

return EventCleanup