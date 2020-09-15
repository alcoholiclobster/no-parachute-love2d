local Concord = require("lib.concord")
local maf = require("lib.maf")

local CharacterRespawn = Concord.system({
    pool = {"character", "respawn"}
})

function CharacterRespawn:update(deltaTime)
    for _, e in ipairs(self.pool) do
        local newInstance = self:getWorld().gameManager:createCharacter()
            :give("rotationSpeed", e.rotationSpeed.value)
            :give("position", maf.vec3(0, 0, e.position.value.z - 1))

        if e.playerControlled then
            newInstance:give("playerControlled")
        end

        e:destroy()
    end
end

return CharacterRespawn