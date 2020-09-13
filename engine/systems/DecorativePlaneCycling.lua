local Concord = require("lib.concord")

local Movement = Concord.system({
    pool = {"position", "decorativePlane"}
})

function Movement:update(deltaTime)
    for _, e in ipairs(self.pool) do
        if e.position.value.z > 0 then
            e.position.value.z = e.position.value.z - 100
        end
    end
end

return Movement