local Concord = require("lib.concord")

local LifeTime = Concord.system({
    pool = {"lifeTime"}
})

function LifeTime:update(deltaTime)
    for _, e in ipairs(self.pool) do
        e.lifeTime.value = e.lifeTime.value - deltaTime
        if e.lifeTime.value < 0 then
            e:destroy()
        end
    end
end

return LifeTime