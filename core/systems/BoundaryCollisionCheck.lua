local Concord = require("lib.concord")
local maf = require("lib.maf")

local BoundaryCollisionCheck = Concord.system({
    pool = {
        "position",
        "size",
        "velocity",
        "canCollideWithBoundaries"
    },

    tunnelCenterPool = {"position", "tunnelCenter"},
})

function BoundaryCollisionCheck:update()
    local centerPos = maf.vec3(0, 0, 0)
    if self.tunnelCenterPool[1] then
        centerPos = self.tunnelCenterPool[1].position.value
    end

    for _, e in ipairs(self.pool) do
        local maxPos = 5 - e.size.value.x * 0.3

        if e.position.value.x < -maxPos + centerPos.x then
            e.position.value.x = -maxPos + centerPos.x
            e.velocity.value.x = 0
        elseif e.position.value.x > maxPos + centerPos.x then
            e.position.value.x = maxPos + centerPos.x
            print("hi")
            e.velocity.value.x = 0
        end

        if e.position.value.y < -maxPos + centerPos.y then
            e.position.value.y = -maxPos + centerPos.y
            e.velocity.value.y = 0
        elseif e.position.value.y > maxPos + centerPos.y then
            e.position.value.y = maxPos + centerPos.y
            e.velocity.value.y = 0
        end
    end
end

return BoundaryCollisionCheck