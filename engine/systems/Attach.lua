local Concord = require("lib.concord")
local mathUtils = require("utils.math")

local Attach = Concord.system({
    pool = {"position", "attachToEntity"}
})

function Attach:update(deltaTime)
    for _, e in ipairs(self.pool) do
        if not e.attachToEntity.value or not e.attachToEntity.value:inWorld(self:getWorld()) then
            e:destroy()
        else
            -- Relative position
            if e.attachOffset then
                local offset = mathUtils.rotateVector2D(e.attachOffset.value, e.attachToEntity.value.rotation.value)
                offset.z = e.attachOffset.value.z
                e.position.value = e.attachToEntity.value.position.value + offset
            else
                e.position.value = e.attachToEntity.value.position.value:clone()
            end

            -- Relative rotation
            if e.rotation then
                if e.attachRotation then
                    e.rotation.value = e.attachToEntity.value.rotation.value + e.attachRotation.value
                else
                    e.rotation.value = e.attachToEntity.value.rotation.value
                end
            end
        end
    end
end

return Attach