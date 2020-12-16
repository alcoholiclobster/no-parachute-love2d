local Concord = require("lib.concord")
local maf = require("lib.maf")

local TunnelShape = Concord.system({
    tunnelEndPool = {"position", "tunnelEnd"},
    tunnelCenterPool = {"position", "tunnelCenter"},
    sidePlanePool = {"position", "sidePlane"},
    playerCharactersPool = {"controlledByPlayer", "position", "alive"},
})

function TunnelShape:init()
    Concord.entity(self:getWorld())
        :give("tunnelEnd")
        :give("position", maf.vec3(0, 0, -100))
        :give("velocity", maf.vec3(4, 0, 0))
        :give("rotation", 0)
        :give("rotationSpeed", 0.1)

    Concord.entity(self:getWorld())
        :give("tunnelCenter")
        :give("drawable")
        :give("fillMode", "fill")
        :give("rotation", 0)
        :give("size", maf.vec3(1, 1, 1))
        :give("color", 0, 1, 0, 1)
        :give("position", maf.vec3(0, 0, 0))
end

function TunnelShape:update(deltaTime)
    for _, e in ipairs(self.tunnelEndPool) do
        e.position.value = e.position.value + e.velocity.value * deltaTime
    end

    local tunnelCenter = self.tunnelCenterPool[1]
    local player = self.playerCharactersPool[1]
    if not tunnelCenter or not player then
        return
    end

    local targetSidePlane = nil
    local minDistance = 200
    for _, e in ipairs(self.sidePlanePool) do
        local distance = player.position.value.z - e.position.value.z
        if distance < minDistance then
            minDistance = distance
            targetSidePlane = e
        end
    end

    if targetSidePlane then
        tunnelCenter.position.value.x = targetSidePlane.position.value.x--tunnelCenter.position.value.x + (targetSidePlane.position.value.x - tunnelCenter.position.value.x) * deltaTime * 10
        tunnelCenter.position.value.y = targetSidePlane.position.value.y--tunnelCenter.position.value.y + (targetSidePlane.position.value.y - tunnelCenter.position.value.y) * deltaTime * 10
        tunnelCenter.position.value.z = player.position.value.z
    end
end

return TunnelShape