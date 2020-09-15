local Concord = require("lib.concord")
local maf = require("lib.maf")

local LimbDetach = Concord.system({
    pool = {"limbParent", "lastCollidedObstacle", "alive"}
})

function LimbDetach:update(deltaTime)
    for _, e in ipairs(self.pool) do
        -- Spawn detached limb
        local obstacle = e.lastCollidedObstacle.value
        local detachedLimbPosition = maf.vec3(
            e.position.value.x,
            e.position.value.y,
            obstacle.position.value.z + 0.5
        )
        Concord.entity(self:getWorld())
            :give("name", "detached_limb")
            :give("drawable")
            :give("destroyAboveCamera")
            :give("position", detachedLimbPosition)
            :give("size", maf.vec3(e.size.value.x, e.size.value.y, e.size.value.z))
            :give("rotation", e.rotation.value)
            :give("texture", e.texture.value)

        -- Shake camera
        if e.limbParent.value.playerControlled then
            Concord.entity(self:getWorld()):give("cameraShakeEvent", 2)
        end

        -- Change texture
        if e.limbMissingTexture then
            e:give("texture", e.limbMissingTexture.value)
        else
            e:remove("texture")
        end

        e:remove("alive")
    end
end

return LimbDetach