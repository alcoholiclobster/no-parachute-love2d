local Concord = require("lib.concord")
local maf = require("lib.maf")
local assets = require("core.assets")
local mathUtils = require("utils.math")

local LevelStreaming = Concord.system({
    pool = {"levelStreamer"},
    cameraPool = {"camera"},
    tunnelEndPool = {"tunnelEnd", "position", "rotation"},
    playerCharactersPool = {"controlledByPlayer", "velocity", "alive"}
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
        :give("size", maf.vec3(texture:getWidth() / 128 * 10, texture:getHeight() / 128 * 10))
        :give("rotation", rotation)
        :give("drawable")
        :give("destroyOutOfBounds")
        :give("obstacleNotAbovePlayer")

    if not plane.decorative then
        local imageData = assets.textureImageData(texture)
        entity:give("planeTextureColor", imageData:getPixel(0, 0))

        local canvas = love.graphics.newCanvas(texture:getWidth(), texture:getHeight())
        love.graphics.setCanvas(canvas)
        love.graphics.clear()
        love.graphics.setBlendMode("alpha")
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.draw(texture, 0, 0)
        if plane.breakable then
            entity:give("breakableObstacle")

            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.setBlendMode("multiply", "premultiplied")
            love.graphics.draw(assets.texture("plane_cracks"), 0, 0)
            love.graphics.setBlendMode("alpha")
        end
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

function LevelStreaming:init()
    Concord.entity(self:getWorld())
        :give("levelStreamer")
end

function LevelStreaming:update(deltaTime)
    local camera = self.cameraPool[1]
    local levelStreamerEntity = self.pool[1]
    local tunnelEnd = self.tunnelEndPool[1]
    if not levelStreamerEntity or not camera then
        return
    end

    local levelStreamer = levelStreamerEntity.levelStreamer
    local world = self:getWorld()
    local levelConfig = world.gameManager.levelConfig

    if levelStreamer.lastIndex < #levelConfig.planes then
        local nextObstacle = levelConfig.planes[levelStreamer.lastIndex + 1]
        local nextObstacleZ = levelStreamer.lastZ - nextObstacle.distance
        if camera.position.value.z - 100 < nextObstacleZ then
            levelStreamer.lastZ = nextObstacleZ
            levelStreamer.lastIndex = levelStreamer.lastIndex + 1

            if nextObstacle.name then
                local planeConfig = levelConfig.planeTypes[nextObstacle.name]
                local positionOffset = maf.vec3(0, 0, 0)
                if nextObstacle.position then
                    positionOffset = maf.vec3(unpack(nextObstacle.position))
                end

                local planePosition = maf.vec3(0, 0, nextObstacleZ)
                local planeRotation = math.rad(nextObstacle.rotation or 0)

                if tunnelEnd then
                    planePosition.x = planePosition.x + tunnelEnd.position.value.x
                    planePosition.y = planePosition.y + tunnelEnd.position.value.y

                    planeRotation = planeRotation + tunnelEnd.rotation.value
                end

                spawnLevelPlane(
                    world,
                    planeConfig,
                    planePosition,
                    positionOffset,
                    planeRotation,
                    levelStreamer.lastIndex
                )
            end

            if nextObstacle.switchSidePlanes then
                levelStreamer.sidePlanesIndex = levelStreamer.sidePlanesIndex + 1
            end

            if nextObstacle.tunnelShape then
                local s = nextObstacle.tunnelShape
                Concord.entity(world)
                    :give("updateTunnelShapeEvent",
                        s.direction and maf.vec3(s.direction[1], s.direction[2], 0),
                        s.offset and maf.vec3(s.offset[1], s.offset[2], 0),
                        s.rotationSpeed)
            end

            if nextObstacle.fogColor then
                camera.camera.fogColor = {
                    nextObstacle.fogColor[1] / 255,
                    nextObstacle.fogColor[2] / 255,
                    nextObstacle.fogColor[3] / 255,
                    1
                }
            end

            if nextObstacle.fallSpeed then
                if self.playerCharactersPool[1] then
                    self.playerCharactersPool[1].velocity.value.z = -nextObstacle.fallSpeed
                end
                self:getWorld().gameState.fallSpeed = nextObstacle.fallSpeed
            end

            if nextObstacle.emit then
                local eventEntity = Concord.entity(world)

                if nextObstacle.emit.args then
                    eventEntity:give(nextObstacle.emit.name, unpack(nextObstacle.emit.args))
                else
                    eventEntity:give(nextObstacle.emit.name)
                end
            end

            if nextObstacle.showText then
                self:getWorld().gameManager.ui:showText(nextObstacle.showText.label, nextObstacle.showText.duration)
            elseif nextObstacle.hideText then
                self:getWorld().gameManager.ui:hideText()
            end
        end
    end
end

return LevelStreaming