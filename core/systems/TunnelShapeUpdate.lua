local Concord = require("lib.concord")

local TunnelShapeUpdate = Concord.system({
    pool = {"updateTunnelShapeEvent"},
    tunnelEndPool = {"position", "tunnelEnd"},
})

function TunnelShapeUpdate:update()
    local tunnelEnd = self.tunnelEndPool[1]
    if not tunnelEnd then
        return
    end

    for _, e in ipairs(self.pool) do
        local event = e.updateTunnelShapeEvent
        if event.rotationSpeed then
            if event.rotationSpeed ~= 0 then
                tunnelEnd:give("rotationSpeed", event.rotationSpeed)
            else
                tunnelEnd:remove("rotationSpeed")
            end
        end
        if event.direction then
            tunnelEnd.tunnelEnd.direction = event.direction:clone()
        end
        if event.offset then
            tunnelEnd.position.value = tunnelEnd.position.value + event.offset
        end
        e:destroy()
    end
end

return TunnelShapeUpdate