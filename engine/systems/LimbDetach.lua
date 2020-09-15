local Concord = require("lib.concord")

local LimbDetach = Concord.system({
    pool = {"limbParent", "lastCollidedObstacle", "alive"}
})

function LimbDetach:update(deltaTime)
    for _, e in ipairs(self.pool) do
        if e.limbParent.value.playerControlled then
            Concord.entity(self:getWorld()):give("cameraShakeEvent", 2)
        end
        local obstacle = e.lastCollidedObstacle.value
        e.position.value.z = obstacle.position.value.z + 0.5
        e:remove("alive")
        e:remove("limbParent")
    end
end

return LimbDetach