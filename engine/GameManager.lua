local class = require("lib.middleclass")
local Concord = require("lib.concord")
local maf = require("lib.maf")
local assets = require("engine.assets")
local LevelGenerator = require("engine.LevelGenerator")

Concord.utils.loadNamespace("engine/components")

local GameManager = class("GameManager")

function GameManager:initialize(levelConfig, uiScreen)
    self.levelConfig = levelConfig
    self.levelGenerator = LevelGenerator:new(self.levelConfig)
    self.levelGenerator:generate()
    self.ui = uiScreen

    self.world = Concord.world()
    self.world.gameManager = self

    self.world:addSystem(require("engine.systems.GameInit"))
    self.world:addSystem(require("engine.systems.CharacterSpawn"))
    self.world:addSystem(require("engine.systems.Decals"))
    self.world:addSystem(require("engine.systems.LifeTime"))
    self.world:addSystem(require("engine.systems.BloodSpawnOnScreen"))
    self.world:addSystem(require("engine.systems.BloodSpawn"))
    self.world:addSystem(require("engine.systems.ParticleEmitter"))
    self.world:addSystem(require("engine.systems.ObstacleCollisionCheck"))
    self.world:addSystem(require("engine.systems.PlayerControl"))
    self.world:addSystem(require("engine.systems.CharacterAI"))
    self.world:addSystem(require("engine.systems.CharacterMovement"))
    self.world:addSystem(require("engine.systems.PlayerRotation"))
    self.world:addSystem(require("engine.systems.Rotation"))
    self.world:addSystem(require("engine.systems.Movement"))
    self.world:addSystem(require("engine.systems.Friction"))
    self.world:addSystem(require("engine.systems.Gravity"))
    self.world:addSystem(require("engine.systems.LimbPoses"))
    self.world:addSystem(require("engine.systems.Attach"))
    self.world:addSystem(require("engine.systems.CameraFollowPlayer"))
    self.world:addSystem(require("engine.systems.CameraShaking"))
    self.world:addSystem(require("engine.systems.BoundaryCollisionCheck"))
    self.world:addSystem(require("engine.systems.DecorativePlaneCycling"))
    self.world:addSystem(require("engine.systems.ObstacleSpawn"))
    self.world:addSystem(require("engine.systems.DestroyOutOfBounds"))
    self.world:addSystem(require("engine.systems.ObstacleCollisionProcessing"))
    self.world:addSystem(require("engine.systems.CharacterDeath"))
    self.world:addSystem(require("engine.systems.LimbObstacleCollision"))
    self.world:addSystem(require("engine.systems.LimbBoundaryCollision"))
    self.world:addSystem(require("engine.systems.LimbDetach"))
    self.world:addSystem(require("engine.systems.BloodParticleCollision"))
    self.world:addSystem(require("engine.systems.DetachedLimbCollision"))
    self.world:addSystem(require("engine.systems.LevelFinish"))
    self.world:addSystem(require("engine.systems.LevelProgress"))
    self.world:addSystem(require("engine.systems.PlaneRendering"))
    self.world:addSystem(require("engine.systems.debug.DebugCollisions"))
    self.world:addSystem(require("engine.systems.debug.DebugInfo"))
    self.world:addSystem(require("engine.systems.debug.DebugFrameRateGraph"))
    self.world:addSystem(require("engine.systems.ScreenRendering"))
    self.world:addSystem(require("engine.systems.EventCleanup"))
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