local Concord = require("lib.concord")
local maf = require("lib.maf")
local mathUtils = require("utils.math")

local Attach = Concord.system({
    pool = {"position", "attachToEntity", "attachOffset"}
})

function Attach:update(deltaTime)
    for _, e in ipairs(self.pool) do
        if not e.attachToEntity.value or not e.attachToEntity.value:inWorld(self:getWorld()) then
            e:destroy()
        else
            local offset = mathUtils.rotateVector2D(e.attachOffset.value, e.attachToEntity.value.rotation.value)
            offset.z = e.attachOffset.value.z
            e.position.value = e.attachToEntity.value.position.value + offset
            if e.attachRotation and e.rotation then
                e.rotation.value = e.attachToEntity.value.rotation.value + e.attachRotation.value
            end
        end
    end
end

return Attach