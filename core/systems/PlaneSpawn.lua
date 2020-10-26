local Concord = require("lib.concord")
local maf = require("lib.maf")
local assets = require("core.assets")
local mathUtils = require("utils.math")

local PlaneSpawn = Concord.system({
    pool = {"planeSpawner"},
    cameraPool = {"camera"}
})

local function spawnPlane(world, plane, worldPosition, localPositionOffset, rotation)
    local texture = assets.texture(plane.texture)

    if plane.rotation then
        rotation = rotation + math.rad(plane.rotation)
    end

    local spawnPosition = worldPosition:clone()
    local localPosition = localPositionOffset
    if plane.position then
        localPosition = localPosition + maf.vec3(plane.position[1], plane.position[2], plane.position[3])
    end
    spawnPosition = spawnPosition + mathUtils.rotateVector2D(localPosition, rotation)

    local entity = Concord.entity(world)
        :give("position", spawnPosition)
        :give("size", maf.vec3(10, 10))
        :give("rotation", rotation)
        :give("drawable")
        :give("destroyOutOfBounds")

    if not plane.decorative then
        local canvas = love.graphics.newCanvas(128, 128)
        love.graphics.setCanvas(canvas)
        love.graphics.clear()
        love.graphics.setBlendMode("alpha")
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.draw(texture, 0, 0)
        love.graphics.setCanvas()
        canvas:setFilter("nearest", "nearest")

        entity:give("obstaclePlane")
        entity:give("texture", canvas)
        entity:give("collisionTexture", texture)
        entity:give("color", 1, 1, 1, 1)
    else
        entity:give("texture", texture)
    end

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

    return entity
end

local function spawnLevelPlane(world, planeConfig, worldPosition, localPosition, rotation, index)
    for i, plane in ipairs(planeConfig.planes) do
        local entity = spawnPlane(world, plane, worldPosition, localPosition, rotation)
        entity:give("name", "plane_"..index.."_"..i)
        entity:give("planeSpawnEvent")
    end
end

function PlaneSpawn:update(deltaTime)
    local camera = self.cameraPool[1]
    if not camera then
        return
    end

    local world = self:getWorld()
    local levelConfig = world.gameManager.levelConfig

    for _, e in ipairs(self.pool) do
        if e.planeSpawner.lastIndex < #levelConfig.planes then
            local nextObstacle = levelConfig.planes[e.planeSpawner.lastIndex + 1]
            local nextObstacleZ = e.planeSpawner.lastZ - nextObstacle.distance
            if camera.position.value.z - 100 < nextObstacleZ then
                e.planeSpawner.lastZ = nextObstacleZ
                e.planeSpawner.lastIndex = e.planeSpawner.lastIndex + 1

                local planeConfig = levelConfig.planeTypes[nextObstacle.name]
                local positionOffset = maf.vec3(0, 0, 0)
                if nextObstacle.position then
                    positionOffset = maf.vec3(unpack(nextObstacle.position))
                end
                spawnLevelPlane(
                    world,
                    planeConfig,
                    maf.vec3(0, 0, nextObstacleZ),
                    positionOffset,
                    math.rad(nextObstacle.rotation or 0),
                    e.planeSpawner.lastIndex
                )

                if nextObstacle.switchSidePlanes then
                    e.planeSpawner.sidePlanesIndex = e.planeSpawner.sidePlanesIndex + 1
                end
            end
        end
    end
end

return PlaneSpawn