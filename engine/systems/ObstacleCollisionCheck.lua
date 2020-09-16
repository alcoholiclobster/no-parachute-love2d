local Concord = require("lib.concord")
local maf = require("lib.maf")
local mathUtils = require("utils.math")
local assets = require("engine.assets")

local ObstacleCollisionCheck = Concord.system({
    obstaclePool = {"obstaclePlane", "position", "collisionTexture"},
    movingPool = {"position", "velocity"},
    limbsPool = {"position", "limbParent"},
})

local function hitTestEntity(obstacle, entity)
    local point = entity.position.value
    if entity.obstacleCollisionCheckOffset then
        local offset = entity.obstacleCollisionCheckOffset.value
        point = point + mathUtils.rotateVector2D(offset, entity.rotation.value)
    end
    local offset = mathUtils.rotateVector2D(
        maf.vec3(
            point.x - obstacle.position.value.x,
            point.y - obstacle.position.value.y
        ),

        -obstacle.rotation.value
    )

    local imageData = assets.textureImageData(obstacle.collisionTexture.value)

    local imageWidth, imageHeight = imageData:getWidth(), imageData:getHeight()
    local tx = math.floor((offset.x + obstacle.size.value.x * 0.5) / obstacle.size.value.x * imageWidth)
    local ty = math.floor((offset.y + obstacle.size.value.y * 0.5) / obstacle.size.value.y * imageHeight)
    if tx < 0 or tx > imageWidth - 1 or ty < 0 or ty > imageHeight - 1 then
        return false
    end
    local _, _, _, alpha = imageData:getPixel(tx, ty)

    if alpha > 0 then
        return true, point, tx, ty
    end

    return false
end

function ObstacleCollisionCheck:update(deltaTime)
    for _, obstacle in ipairs(self.obstaclePool) do
        for _, entity in ipairs(self.limbsPool) do
            local parentZ = entity.limbParent.value.position.value.z
            if parentZ + entity.limbParent.value.velocity.value.z * deltaTime < obstacle.position.value.z and
               parentZ > obstacle.position.value.z
            then
                local hit, pos, tx, ty = hitTestEntity(obstacle, entity)
                if hit then
                    entity:give("lastCollidedObstacle", obstacle, pos, tx, ty)
                end
            end
        end

        for _, entity in ipairs(self.movingPool) do
            local entityZ = entity.position.value.z - 0.5
            if entityZ + entity.velocity.value.z * deltaTime < obstacle.position.value.z and
               entityZ > obstacle.position.value.z
            then
                local hit, pos, tx, ty = hitTestEntity(obstacle, entity)
                if hit then
                    entity:give("lastCollidedObstacle", obstacle, pos, tx, ty)
                end
            end
        end
    end
end

return ObstacleCollisionCheck