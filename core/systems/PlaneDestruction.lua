local Concord = require("lib.concord")
local mathUtils = require("utils.math")
local maf = require("lib.maf")
local assets = require("core.assets")

local PlaneDestruction = Concord.system({
    pool = {"breakableObstacle", "obstacleHitByEntityEvent"}
})

function PlaneDestruction:update(deltaTime)
    local gameManager = self:getWorld().gameManager

    for _, e in ipairs(self.pool) do
        local entity = e.obstacleHitByEntityEvent.value
        if entity.velocity and entity.character then
            local velocityIncrease = mathUtils.clamp01(entity.velocity.value.z / -gameManager.levelConfig.fallSpeed - 1)

            if velocityIncrease > 0.1 then
                e.obstacleHitByEntityEvent.value:remove("obstacleCollisionEvent")
                love.graphics.setCanvas(e.texture.value)
                love.graphics.setBlendMode("multiply", "premultiplied")
                love.graphics.setColor(1, 1, 1, 1)
                love.graphics.draw(assets.texture("plane_broken"), 0, 0)
                love.graphics.setCanvas()
                love.graphics.setBlendMode("alpha")

                if entity.controlledByPlayer then
                    Concord.entity(self:getWorld()):give("cameraShakeSource", 3)
                end

                local hitPos = e.obstacleHitByEntityEvent.value.position.value
                Concord.entity(self:getWorld())
                    :give("position", maf.vec3(hitPos.x, hitPos.y, hitPos.z))
                    :give("particleEmitDelay", 0)
                    :give("lifeTime", 0)
                    :give("particleColor", e.planeTextureColor.r, e.planeTextureColor.g, e.planeTextureColor.b, 1, true)
                    :give("particleSize", 0.08, 0.16)
                    :give("particleFriction", 0.1, 0.1)
                    :give("particleGravity", maf.vec3(0, 0, -30))
                    :give("particleRandomRotation")
                    :give("particleEmitCount", 50, 60)
                    :give("particleSpeed", -10+entity.velocity.value.x, 10+entity.velocity.value.x, -10+entity.velocity.value.y, 10+entity.velocity.value.y, entity.velocity.value.z, 0)
                    :give("particleLifeTime", 3, 5)

                local screenWidth, screenHeight = love.graphics.getWidth(), love.graphics.getHeight()
                for i = 1, math.random(40, 50) do
                    local s = math.floor(screenHeight/128*math.random(1, 4))
                    local b = math.random() + 0.5
                    Concord.entity(self:getWorld())
                        :give("position2d", screenWidth * math.random(), screenHeight * math.random())
                        :give("size2d", s, s)
                        :give("lifeTime", 1 + math.random() * 2)
                        :give("color", e.planeTextureColor.r*b, e.planeTextureColor.g*b, e.planeTextureColor.b*b, 0.2 + math.random() * 0.4)
                end
            end
        end
    end
end

return PlaneDestruction