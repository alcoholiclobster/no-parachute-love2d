local Concord = require("lib.concord")
local maf = require("lib.maf")
local assets = require("core.assets")
local settings = require "core.settings"

local ParticleEmitter = Concord.system({
    pool = {"position", "particleEmitDelay", "particleEmitCount"}
})

function ParticleEmitter:update(deltaTime)
    for _, e in ipairs(self.pool) do
        e.particleEmitDelay.time = e.particleEmitDelay.time + deltaTime

        if e.particleEmitDelay.time > e.particleEmitDelay.delay then
            e.particleEmitDelay.time = 0

            local count = math.random(e.particleEmitCount.min, e.particleEmitCount.max) * settings.get("particles_quality")
            for i = 1, count do
                local lifeTime = e.particleLifeTime.min + (e.particleLifeTime.max - e.particleLifeTime.min) * math.random()
                local direction = math.random() * math.pi * 2
                local velocity = maf.vec3(math.cos(direction), math.sin(direction), 0)
                if e.particleSpeed then
                    velocity.x = (e.particleSpeed.minX + (e.particleSpeed.maxX - e.particleSpeed.minX) * math.random())
                    velocity.y = (e.particleSpeed.minY + (e.particleSpeed.maxY - e.particleSpeed.minY) * math.random())
                    velocity.z = (e.particleSpeed.minZ + (e.particleSpeed.maxZ - e.particleSpeed.minZ) * math.random())
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
                    :give("particle")
                    :give("lifeTime", lifeTime)
                    :give("velocity", velocity)
                    :give("texture", assets.texture("particle"))
                    :give("destroyOutOfBounds")

                if e.particleColor then
                    local r, g, b = e.particleColor.r, e.particleColor.g, e.particleColor.b
                    if e.particleColor.randomizeBrightness then
                        local brightness = math.random() + 0.5
                        r, g, b = r * brightness, g * brightness, b * brightness
                    end
                    particle:give("color", r, g, b, e.particleColor.a)
                end

                if e.particleFriction then
                    particle:give("friction", e.particleFriction.min + (e.particleFriction.max - e.particleFriction.min) * math.random())
                end

                if e.particleRandomRotation then
                    particle:give("rotation", math.random() * math.pi * 2)
                end

                if e.particleCollisionEnabled then
                    particle:give("canCollideWithObstacles")
                end

                if e.particleGravity then
                    particle:give("gravity", e.particleGravity.value)
                end

                if e.particleTag then
                    particle:give(e.particleTag.value)
                end
            end
        end
    end
end

return ParticleEmitter