local class = require("lib.middleclass")
local Concord = require("lib.concord")

Concord.utils.loadNamespace("core/components")

local GameManager = class("GameManager")

function GameManager:initialize(levelConfig, uiScreen)
    self.levelConfig = levelConfig
    self.ui = uiScreen

    self.world = Concord.world()
    self.world.gameManager = self

    self.world:addSystem(require("core.systems.GameInit"))
    self.world:addSystem(require("core.systems.CharacterSpawn"))
    self.world:addSystem(require("core.systems.Decals"))
    self.world:addSystem(require("core.systems.LifeTime"))
    self.world:addSystem(require("core.systems.DelayedVelocity"))
    self.world:addSystem(require("core.systems.BloodSpawnOnScreen"))
    self.world:addSystem(require("core.systems.BloodSpawn"))
    self.world:addSystem(require("core.systems.ParticleEmitter"))
    self.world:addSystem(require("core.systems.ObstacleCollisionCheck"))
    self.world:addSystem(require("core.systems.PlayerControl"))
    self.world:addSystem(require("core.systems.CharacterAI"))
    self.world:addSystem(require("core.systems.CharacterMovement"))
    self.world:addSystem(require("core.systems.PlayerRotation"))
    self.world:addSystem(require("core.systems.Rotation"))
    self.world:addSystem(require("core.systems.Movement"))
    self.world:addSystem(require("core.systems.Friction"))
    self.world:addSystem(require("core.systems.Gravity"))
    self.world:addSystem(require("core.systems.LimbPoses"))
    self.world:addSystem(require("core.systems.Attach"))
    self.world:addSystem(require("core.systems.CharacterCollision"))
    self.world:addSystem(require("core.systems.CameraFollowPlayer"))
    self.world:addSystem(require("core.systems.CameraShaking"))
    self.world:addSystem(require("core.systems.BoundaryCollisionCheck"))
    self.world:addSystem(require("core.systems.DecorativePlaneCycling"))
    self.world:addSystem(require("core.systems.ObstacleSpawn"))
    self.world:addSystem(require("core.systems.DestroyOutOfBounds"))
    self.world:addSystem(require("core.systems.ObstacleCollisionProcessing"))
    self.world:addSystem(require("core.systems.CharacterDeath"))
    self.world:addSystem(require("core.systems.LimbObstacleCollision"))
    self.world:addSystem(require("core.systems.LimbBoundaryCollision"))
    self.world:addSystem(require("core.systems.LimbDetach"))
    self.world:addSystem(require("core.systems.BloodParticleCollision"))
    self.world:addSystem(require("core.systems.DetachedLimbCollision"))
    self.world:addSystem(require("core.systems.LevelFinish"))
    self.world:addSystem(require("core.systems.LevelProgress"))
    self.world:addSystem(require("core.systems.PlaneRendering"))
    self.world:addSystem(require("core.systems.debug.DebugCollisions"))
    self.world:addSystem(require("core.systems.debug.DebugInfo"))
    self.world:addSystem(require("core.systems.debug.DebugFrameRateGraph"))
    self.world:addSystem(require("core.systems.ScreenRendering"))
    self.world:addSystem(require("core.systems.EventCleanup"))
end

function GameManager:update(deltaTime)
    self.world:emit("update", deltaTime)
end

function GameManager:draw()
    self.world:emit("draw")
end

function GameManager:handleKeyPress(...)
    self.world:emit("keyPress", ...)
end

function GameManager:handleKeyRelease(...)
    self.world:emit("keyRelease", ...)
end

return GameManager