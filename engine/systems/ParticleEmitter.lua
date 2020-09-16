local Concord = require("lib.concord")
local maf = require("lib.maf")
local assets = require("engine.assets")

local ParticleEmitter = Concord.system({
    pool = {"position", "particleEmitDelay", "particleEmitCount"}
})

function ParticleEmitter:update(deltaTime)
    for _, e in ipairs(self.pool) do
        e.particleEmitDelay.time = e.particleEmitDelay.time + deltaTime

        if e.particleEmitDelay.time > e.particleEmitDelay.delay then
            e.particleEmitDelay.time = 0

            local count = math.random(e.particleEmitCount.min, e.particleEmitCount.max)
            for i = 1, count do
                local lifeTime = e.particleLifeTime.min + (e.particleLifeTime.max - e.particleLifeTime.min) * math.random()
                local direction = math.random() * math.pi * 2
                local velocity = maf.vec3(math.cos(direction), math.sin(direction), 0)
                if e.particleSpeed then
                    velocity = velocity * (e.particleSpeed.min + (e.particleSpeed.max - e.particleSpeed.min) * math.random())
                end

                local size = 0.5
                if e.particleSize then
                    size = e.particleSize.min + (e.particleSize.max - e.particleSize.min) * math.random()
                end

                local particle = Concord.entity(self:getWorld())
                    :give("position", maf.vec3(e.position.value.x, e.position.value.y, e.position.value.z))
                    :give("size", maf.vec3(size, size, 0))
                    :give("rotation", 0)
                    :give("drawable")
                    :give("lifeTime", lifeTime)
                    :give("velocity", velocity)
                    :give("texture", assets.texture("particle"))
                    :give("destroyAboveCamera")

                if e.particleColor then
                    particle:give("color", e.particleColor.r, e.particleColor.g, e.particleColor.b, e.particleColor.a)
                end

                if e.particleFriction then
                    particle:give("friction", e.particleFriction.min + (e.particleFriction.max - e.particleFriction.min) * math.random())
                end
            end
        end
    end
end

return ParticleEmitter