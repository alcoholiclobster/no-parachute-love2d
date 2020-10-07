local Concord = require("lib.concord")
local mathUtils = require("utils.math")
local maf = require('lib.maf')

local CameraShaking = Concord.system({
    cameraPool = {"camera", "position"},
    shakesPool = {"cameraShakeSource"},
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
        local shake = shakeLevels[e.cameraShakeSource.level]
        if shake then
            for _, cam in ipairs(self.cameraPool) do
                local dir = maf.vec3(math.random()-0.5, math.random()-0.5, math.random()-0.5)
                cam.position.value = cam.position.value + dir * shake.distance * (1-mathUtils.clamp01(e.cameraShakeSource.time/shake.duration))
            end

            e.cameraShakeSource.time = e.cameraShakeSource.time + deltaTime
            if e.cameraShakeSource.time > shake.duration then
                e:destroy()
            end
        end
    end
end

return CameraShaking