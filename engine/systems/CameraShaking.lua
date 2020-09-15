local Concord = require("lib.concord")
local mathUtils = require("utils.math")
local maf = require('lib.maf')

local CameraShaking = Concord.system({
    cameraPool = {"camera", "position"},
    shakesPool = {"cameraShakeEvent"},
})

local shakeLevels = {
    [1] = {
        duration = 0.25,
        distance = 0.1,
    },
    [2] = {
        duration = 0.3,
        distance = 0.3,
    },
    [3] = {
        duration = 0.5,
        distance = 0.4,
    }
}

function CameraShaking:update(deltaTime)
    for _, e in ipairs(self.shakesPool) do
        local shake = shakeLevels[e.cameraShakeEvent.level]
        if shake then
            for _, cam in ipairs(self.cameraPool) do
                local dir = maf.vec3(math.random()-0.5, math.random()-0.5, math.random()-0.5)
                cam.position.value = cam.position.value + dir * shake.distance * (1-mathUtils.clamp01(e.cameraShakeEvent.time/shake.duration))
            end

            e.cameraShakeEvent.time = e.cameraShakeEvent.time + deltaTime
            if e.cameraShakeEvent.time > shake.duration then
                e:destroy()
            end
        else
            e:destroy()
        end
    end
end

return CameraShaking