local class = require("lib.middleclass")
local Concord = require("lib.concord")
local maf = require("lib.maf")
local assets = require("engine.assets")

Concord.utils.loadNamespace("engine/components")

local GameManager = class("GameManager")

function GameManager:initialize()
    self.world = Concord.world()
    self.world.gameManager = self

    self.world:addSystem(require("engine.systems.Decals"))
    self.world:addSystem(require("engine.systems.LifeTime"))
    self.world:addSystem(require("engine.systems.BloodSpawn"))
    self.world:addSystem(require("engine.systems.ParticleEmitter"))
    self.world:addSystem(require("engine.systems.RespawnTimeout"))
    self.world:addSystem(require("engine.systems.CharacterRespawn"))
    self.world:addSystem(require("engine.systems.ObstacleCollisionCheck"))
    self.world:addSystem(require("engine.systems.PlayerControl"))
    self.world:addSystem(require("engine.systems.CharacterMovement"))
    self.world:addSystem(require("engine.systems.Rotation"))
    self.world:addSystem(require("engine.systems.Movement"))
    self.world:addSystem(require("engine.systems.Friction"))
    self.world:addSystem(require("engine.systems.LimbPoses"))
    self.world:addSystem(require("engine.systems.LimbAttach"))
    self.world:addSystem(require("engine.systems.CameraFollowPlayer"))
    self.world:addSystem(require("engine.systems.CameraShaking"))
    self.world:addSystem(require("engine.systems.BoundaryLimit"))
    self.world:addSystem(require("engine.systems.DecorativePlaneCycling"))
    self.world:addSystem(require("engine.systems.ObstacleSpawn"))
    self.world:addSystem(require("engine.systems.DestroyAboveCamera"))
    self.world:addSystem(require("engine.systems.CharacterDeath"))
    self.world:addSystem(require("engine.systems.LimbDetach"))
    self.world:addSystem(require("engine.systems.PlaneRendering"))
    -- Optional debug systems
    self.world:addSystem(require("engine.systems.debug.DebugCollisions"))
    self.world:addSystem(require("engine.systems.debug.DebugInfo"))
    self.world:addSystem(require("engine.systems.debug.DebugFrameRateGraph"))

    -- Side wall planes
    local count = 40
    for i = 0, count - 1 do
        local z = -100 + i * 100 / count
        Concord.entity(self.world)
            :give("position", maf.vec3(0, 0, z))
            :give("size", maf.vec3(10, 10))
            :give("rotation", math.random(1, 4)*math.pi * 0.5)
            :give("drawable")
            :give("decorativePlane")
            :give("color", 1, 1, 1)
            :give("texture", assets.texture("level1/decorative"..math.random(1, 3)))
    end

    self:createCharacter()
        :give("playerControlled")

    -- Camera
    Concord.entity(self.world)
        :give("position", maf.vec3(0, 0, 0))
        :give("rotation", 0)
        :give("camera")

    -- Obstacle spawner
    Concord.entity(self.world)
        :give("lastObstacleZ", 0)
        :give("distanceBetweenObstacles", 40)
end

function GameManager:createCharacter()
    -- Character
    local character = Concord.entity(self.world)
        :give("name", "character")
        :give("position", maf.vec3(0, 0, -10))
        :give("size", maf.vec3(2.5, 2.5))
        :give("rotation", 0)
        :give("rotationSpeed", 0)
        :give("drawable")
        :give("character")
        :give("alive")
        :give("velocity", maf.vec3(0, 0, -25))
        :give("friction", 7)
        :give("moveDirection")
        :give("texture", assets.texture("player/torso"))
        :give("rotationSpeed", 0.1)

    -- Limbs
    -- Right Hand
    Concord.entity(self.world)
        :give("name", "right_hand")
        :give("position")
        :give("size", maf.vec3(2.5, 2.5))
        :give("rotation", 0)
        :give("drawable")
        :give("alive")
        :give("limbParent", character)
        :give("limbRotation", 0)
        :give("limbRotationPoses", -0.2, 0.2, 0.1, -0.3)
        :give("texture", assets.texture("player/hand"))
        :give("limbMissingTexture", assets.texture("player/hand_missing"))
        :give("offset", maf.vec3(0, 0, 0))
        :give("obstacleCollisionCheckOffset", maf.vec3(0.55, -0.7, 0))

    -- Left Hand
    Concord.entity(self.world)
        :give("name", "left_hand")
        :give("position")
        :give("size", maf.vec3(-2.5, 2.5))
        :give("rotation", 0)
        :give("drawable")
        :give("alive")
        :give("limbParent", character)
        :give("limbRotation", 0)
        :give("limbRotationPoses", -0.2, 0.2, -0.1, 0.3)
        :give("texture", assets.texture("player/hand"))
        :give("limbMissingTexture", assets.texture("player/hand_missing2"))
        :give("offset", maf.vec3(-0.08, 0, 0))
        :give("obstacleCollisionCheckOffset", maf.vec3(-0.55, -0.7, 0))

    -- Right Leg
    Concord.entity(self.world)
        :give("name", "right_leg")
        :give("position")
        :give("size", maf.vec3(2.5, 2.5))
        :give("rotation", 0)
        :give("drawable")
        :give("alive")
        :give("limbParent", character)
        :give("limbRotation", 0)
        :give("limbRotationPoses", -0.2, 0.2, 0.2, -0.25)
        :give("texture", assets.texture("player/leg"))
        :give("limbMissingTexture", assets.texture("player/leg_missing"))
        :give("offset", maf.vec3(0, 0, 0))
        :give("obstacleCollisionCheckOffset", maf.vec3(0.4, 0.85, 0))

    -- Left Leg
    Concord.entity(self.world)
        :give("name", "left_leg")
        :give("position")
        :give("size", maf.vec3(-2.5, 2.5))
        :give("rotation", 0)
        :give("drawable")
        :give("alive")
        :give("limbParent", character)
        :give("limbRotation", 0)
        :give("limbRotationPoses", -0.2, 0.2, -0.2, 0.25)
        :give("texture", assets.texture("player/leg"))
        :give("limbMissingTexture", assets.texture("player/leg_missing2"))
        :give("offset", maf.vec3(-0.08, 0, 0))
        :give("obstacleCollisionCheckOffset", maf.vec3(-0.4, 0.85, 0))

    return character
end

function GameManager:update(deltaTime)
    self.world:emit("update", deltaTime)
end

function GameManager:draw()
    love.graphics.clear(0, 0, 0, 1)
    self.world:emit("draw")
    love.graphics.origin()
    love.graphics.setColor(1, 1, 1, 1)
end

function GameManager:handleKeyPress(...)
    self.world:emit("keyPress", ...)
end

function GameManager:handleKeyRelease(...)
    self.world:emit("keyRelease", ...)
end

return GameManager