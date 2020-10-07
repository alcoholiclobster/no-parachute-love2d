local Concord = require("lib.concord")

local Rotation = Concord.system({
    pool = {"rotation", "rotationSpeed"}
})

function Rotation:update(deltaTime)
    for _, e in ipairs(self.pool) do
        e.rotation.value = e.rotation.value + e.rotationSpeed.value * deltaTime
    end
end

return Rotation