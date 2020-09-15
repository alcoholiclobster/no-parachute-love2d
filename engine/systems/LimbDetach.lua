local Concord = require("lib.concord")

local LimbDetach = Concord.system({
    pool = {"limbParent", "lastCollidedObstacle", "alive"}
})

function LimbDetach:update(deltaTime)
    for _, e in ipairs(self.pool) do
        local obstacle = e.lastCollidedObstacle.value
        e.position.value.z = obstacle.position.value.z + 0.5
        e:remove("alive")
        e:remove("limbParent")
    end
end

return LimbDetach