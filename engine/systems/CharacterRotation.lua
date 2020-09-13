local Concord = require("lib.concord")
local maf = require("lib.maf")
local mathUtils = require("utils.math")

local CharacterRotation = Concord.system({
    pool = {"velocity", "character", "rotationSpeed", "alive"},
})

function CharacterRotation:update(deltaTime)
    for _, e in ipairs(self.pool) do
        e.rotation.value = e.rotation.value + deltaTime * e.rotationSpeed.value
    end
end

return CharacterRotation