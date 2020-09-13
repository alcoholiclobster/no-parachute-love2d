local Concord = require("lib.concord")

local BoundaryLimit = Concord.system({
    pool = {"position", "size", "velocity"}
})

function BoundaryLimit:update(deltaTime)
    for _, e in ipairs(self.pool) do
        local maxPos = 5 - e.size.value.x * 0.3
        if e.position.value.x < -maxPos then
            e.position.value.x = -maxPos
            e.velocity.value.x = 0
        elseif e.position.value.x > maxPos then
            e.position.value.x = maxPos
            e.velocity.value.x = 0
        end

        if e.position.value.y < -maxPos then
            e.position.value.y = -maxPos
            e.velocity.value.y = 0
        elseif e.position.value.y > maxPos then
            e.position.value.y = maxPos
            e.velocity.value.y = 0
        end
    end
end

return BoundaryLimit