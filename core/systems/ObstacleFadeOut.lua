local Concord = require("lib.concord")
local mathUtils = require("utils.math")
local settings = require("utils.settings")

local ObstacleFadeOut = Concord.system({
    characterPool = {"controlledByPlayer", "position", "alive"},
    pool = {"color", "obstaclePlane"}
})

function ObstacleFadeOut:update(deltaTime)
    local character = self.characterPool[1]
    if not character then
        return
    end

    if not settings.get("plane_fading") then
        return
    end

    for _, e in ipairs(self.pool) do
        local distance = e.position.value.z - character.position.value.z
        if distance > 0 then
            e.color.a = 1 - mathUtils.clamp01(distance / 8)
        end
    end
end

return ObstacleFadeOut