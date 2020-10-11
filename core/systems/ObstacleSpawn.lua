local Concord = require("lib.concord")
local maf = require("lib.maf")
local assets = require("core.assets")
local mathUtils = require("utils.math")

local ObstacleSpawn = Concord.system({
    pool = {"lastObstacleZ", "lastObstacleIndex"},
    cameraPool = {"camera"}
})

local function spawnObstaclePlane(world, plane, position, rotation)
    local texture = assets.texture(plane.texture)
    local canvas = love.graphics.newCanvas(128, 128)
    love.graphics.setCanvas(canvas)
    love.graphics.clear()
    love.graphics.setBlendMode("alpha")
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(texture, 0, 0)
    love.graphics.setCanvas()
    canvas:setFilter("nearest", "nearest")

    if plane.rotation then
        rotation = rotation + math.rad(plane.rotation)
    end

    local spawnPosition = position:clone()
    if plane.position then
        spawnPosition = spawnPosition + mathUtils.rotateVector2D(maf.vec3(plane.position[1], plane.position[2], plane.position[3]), rotation)
    end

    local entity = Concord.entity(world)
        :give("position", spawnPosition)
        :give("size", maf.vec3(10, 10))
        :give("rotation", rotation)
        :give("drawable")
        :give("obstaclePlane")
        :give("destroyOutOfBounds")
        :give("texture", canvas)
        :give("collisionTexture", texture)

    if plane.rotationSpeed then
        entity:give("rotationSpeed", plane.rotationSpeed)
    end

    if plane.velocity then
        local velocity = mathUtils.rotateVector2D(maf.vec3(plane.velocity[1], plane.velocity[2], plane.velocity[3]), rotation)

        if plane.moveDelay then
            entity:give("delayedVelocity", plane.moveDelay, velocity)
        else
            entity:give("velocity", velocity)
        end
    end
end

local function spawnObstacle(world, obstacleType, position, rotation)
    for i, plane in ipairs(obstacleType.planes) do
        spawnObstaclePlane(world, plane, position, rotation)
    end
end

function ObstacleSpawn:update(deltaTime)
    local camera = self.cameraPool[1]
    if not camera then
        return
    end

    local world = self:getWorld()
    local levelConfig = world.gameManager.levelConfig
    -- local levelGenerator = world.gameManager.levelGenerator

    for _, e in ipairs(self.pool) do
        -- local distance = math.abs((camera.position.value.z - 100) - e.lastObstacleZ.value)
        local nextObstacle = levelConfig.obstacles[e.lastObstacleIndex.value + 1]
        local nextObstacleZ = e.lastObstacleZ.value - nextObstacle.distance
        if camera.position.value.z - 100 < nextObstacleZ then
            e.lastObstacleZ.value = nextObstacleZ
            e.lastObstacleIndex.value = e.lastObstacleIndex.value + 1

            local obstacleType = levelConfig.obstacleTypes[nextObstacle.name]
            spawnObstacle(world, obstacleType, maf.vec3(0, 0, nextObstacleZ), math.rad(nextObstacle.rotation))

            if e.lastObstacleIndex.value >= #levelConfig.obstacles then
                e:destroy()
            end
        end
        -- if distance > e.distanceBetweenObstacles.value then

        --     e.lastObstacleIndex.value = e.lastObstacleIndex.value + 1

            -- local obstacle = levelGenerator.obstacles[e.lastObstacleIndex.value]

            -- if obstacle and not obstacle.freeSpace then
            --     spawnObstacle(world, obstacle, maf.vec3(0, 0, camera.position.value.z - 100 - 0.51))
            --     e.lastObstacleZ.value = camera.position.value.z - 100
            -- else
            --     e.lastObstacleZ.value = e.lastObstacleZ.value - obstacle.freeSpace * e.distanceBetweenObstacles.value
            -- end

            -- if e.lastObstacleIndex.value == #levelGenerator.obstacles then
            --     e:destroy()
            -- end
        -- end
    end
end

return ObstacleSpawn