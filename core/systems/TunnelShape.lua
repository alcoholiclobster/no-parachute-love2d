local Concord = require("lib.concord")
local maf = require("lib.maf")

local TunnelShape = Concord.system({
    cameraPool = {"camera"},
    tunnelEndPool = {"position", "tunnelEnd"},
    tunnelCenterPool = {"position", "tunnelCenter"},
    tunnelTopPool = {"position", "tunnelTop"},
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
    Concord.entity(self:getWorld())
        :give("tunnelTop")
        :give("rotation", 0)
        :give("size", maf.vec3(10, 10, 1))
        :give("position", maf.vec3(0, 0, 0))
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
    local tunnelTop = self.tunnelTopPool[1]
    local player = self.playerCharactersPool[1]
    if not tunnelCenter or not player then
        return
    end

    local centerSidePlane = nil
    local centerMinDistance = 200

    local topSidePlane = nil
    local topMinDistance = 200

    for _, e in ipairs(self.sidePlanePool) do
        local distance = math.abs(player.position.value.z + player.velocity.value.z * 0.2 - e.position.value.z)
        if distance < centerMinDistance then
            centerMinDistance = distance
            centerSidePlane = e
        end

        distance = math.abs(camera.position.value.z + player.velocity.value.z * 0.2 - e.position.value.z)
        if distance < topMinDistance then
            topMinDistance = distance
            topSidePlane = e
        end
    end

    if centerSidePlane then
        tunnelCenter.position.value.x = tunnelCenter.position.value.x + (centerSidePlane.position.value.x - tunnelCenter.position.value.x) * deltaTime * 5
        tunnelCenter.position.value.y = tunnelCenter.position.value.y + (centerSidePlane.position.value.y - tunnelCenter.position.value.y) * deltaTime * 5
        tunnelCenter.position.value.z = player.position.value.z

        if centerSidePlane.texture then
            local size = centerSidePlane.texture.value:getWidth() / 128 * 10
            tunnelCenter.size.value.x = size
            tunnelCenter.size.value.y = size
        end
    end

    if topSidePlane then
        tunnelTop.position.value.x = tunnelTop.position.value.x + (topSidePlane.position.value.x - tunnelTop.position.value.x) * deltaTime * 5
        tunnelTop.position.value.y = tunnelTop.position.value.y + (topSidePlane.position.value.y - tunnelTop.position.value.y) * deltaTime * 5
        tunnelTop.position.value.z = camera.position.value.z
    end
end

return TunnelShape