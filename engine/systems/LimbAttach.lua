local Concord = require("lib.concord")
local maf = require("lib.maf")
local mathUtils = require("utils.math")

local LimbAttach = Concord.system({
    pool = {"position", "rotation", "limbParent", "limbRotation", "offset"}
})

function LimbAttach:update(deltaTime)
    for _, e in ipairs(self.pool) do
        if not e.limbParent.value or not e.limbParent.value:inWorld(self:getWorld()) then
            e:destroy()
        else
            local offset = mathUtils.rotateVector2D(e.offset.value, e.limbParent.value.rotation.value)
            e.position.value = e.limbParent.value.position.value + offset + maf.vec3(0, 0, -0.26)
            e.rotation.value = e.limbParent.value.rotation.value + e.limbRotation.value
        end
    end
end

return LimbAttach