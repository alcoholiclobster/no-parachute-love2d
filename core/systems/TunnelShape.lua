local Concord = require("lib.concord")
local maf = require("lib.maf")

local TunnelShape = Concord.system({
    cameraPool = {"camera"},
    tunnelEndPool = {"position", "tunnelEnd"},
    tunnelCenterPool = {"position", "tunnelCenter"},
    sidePlanePool = {"position", "sidePlane"},
    playerCharactersPool = {"controlledByPlayer", "position", "alive"},
})

function TunnelShape:init()
    Concord.entity(self:getWorld())
        :give("tunnelEnd")
        :give("position", maf.vec3(0, 0, -100))
        :give("velocity", maf.vec3(0, 0, 0))
        :give("rotation", 0)

    Concord.entity(self:getWorld())
        :give("tunnelCenter")
        :give("rotation", 0)
        :give("size", maf.vec3(10, 10, 1))
        :give("position", maf.vec3(0, 0, 0))
        -- :give("color", 0, 1, 0, 1)
        -- :give("drawable")
        -- :give("fillMode", "line")
end

function TunnelShape:update(deltaTime)
    local camera = self.cameraPool[1]
    if not camera then
        return
    end

    for _, e in ipairs(self.tunnelEndPool) do
        -- e.velocity.value.x = math.cos(love.timer.getTime() * 2.2) * 6
        -- e.velocity.value.y = math.sin(love.timer.getTime() * 2.2) * 6

        e.position.value.z = camera.position.value.z - 100
    end

    local tunnelCenter = self.tunnelCenterPool[1]
    local player = self.playerCharactersPool[1]
    if not tunnelCenter or not player then
        return
    end

    local targetSidePlane = nil
    local minDistance = 200
    for _, e in ipairs(self.sidePlanePool) do
        local distance = math.abs(player.position.value.z + player.velocity.value.z * 0.2 - e.position.value.z)
        if distance < minDistance then
            minDistance = distance
            targetSidePlane = e
        end
    end

    if targetSidePlane then
        tunnelCenter.position.value.x = tunnelCenter.position.value.x + (targetSidePlane.position.value.x - tunnelCenter.position.value.x) * deltaTime * 5
        tunnelCenter.position.value.y = tunnelCenter.position.value.y + (targetSidePlane.position.value.y - tunnelCenter.position.value.y) * deltaTime * 5
        tunnelCenter.position.value.z = player.position.value.z
    end
end

return TunnelShape