local class = require("lib.middleclass")
local Concord = require("lib.concord")

Concord.utils.loadNamespace("core/components")

local GameManager = class("GameManager")

function GameManager:initialize(levelConfig, uiScreen)
    self.levelConfig = levelConfig
    self.ui = uiScreen

    self.world = Concord.world()
    self.world.gameManager = self

    self.time = 0
    self.deltaTimeMultiplier = 1

    self.world:addSystem(require("core.systems.GameInit"))
    self.world:addSystem(require("core.systems.CharacterSpawn"))
    self.world:addSystem(require("core.systems.LifeTime"))
    self.world:addSystem(require("core.systems.TunnelShapeUpdate"))
    self.world:addSystem(require("core.systems.TunnelShape"))
    self.world:addSystem(require("core.systems.DelayedVelocity"))
    self.world:addSystem(require("core.systems.BloodSpawnOnScreen"))
    self.world:addSystem(require("core.systems.BloodSpawn"))
    self.world:addSystem(require("core.systems.ObstacleCollisionCheck"))
    self.world:addSystem(require("core.systems.PlaneDestruction"))
    self.world:addSystem(require("core.systems.ParticleEmitter"))
    self.world:addSystem(require("core.systems.PlayerControl"))
    self.world:addSystem(require("core.systems.CharacterAI"))
    self.world:addSystem(require("core.systems.CharacterMovement"))
    self.world:addSystem(require("core.systems.CharacterFallSpeed"))
    self.world:addSystem(require("core.systems.PlayerRotation"))
    self.world:addSystem(require("core.systems.Rotation"))
    self.world:addSystem(require("core.systems.Movement"))
    self.world:addSystem(require("core.systems.Friction"))
    self.world:addSystem(require("core.systems.Gravity"))
    self.world:addSystem(require("core.systems.LimbPoses"))
    self.world:addSystem(require("core.systems.Attach"))
    -- self.world:addSystem(require("core.systems.CharacterCollision"))
    self.world:addSystem(require("core.systems.CameraFollowPlayer"))
    self.world:addSystem(require("core.systems.CameraShaking"))
    self.world:addSystem(require("core.systems.BoundaryCollisionCheck"))
    self.world:addSystem(require("core.systems.SidePlaneCycling"))
    self.world:addSystem(require("core.systems.SidePlaneTextures"))
    self.world:addSystem(require("core.systems.LevelStreaming"))
    self.world:addSystem(require("core.systems.DestroyOutOfBounds"))
    self.world:addSystem(require("core.systems.ObstacleCollisionProcessing"))
    self.world:addSystem(require("core.systems.LimbObstacleCollision"))
    self.world:addSystem(require("core.systems.LimbBoundaryCollision"))
    self.world:addSystem(require("core.systems.Damage"))
    self.world:addSystem(require("core.systems.CharacterDeath"))
    self.world:addSystem(require("core.systems.LimbDetach"))
    self.world:addSystem(require("core.systems.BloodParticleCollision"))
    self.world:addSystem(require("core.systems.DetachedLimbCollision"))
    self.world:addSystem(require("core.systems.LevelFinish"))
    self.world:addSystem(require("core.systems.LevelProgress"))
    self.world:addSystem(require("core.systems.ObstacleFadeOut"))
    self.world:addSystem(require("core.systems.CameraSpeedFOV"))
    self.world:addSystem(require("core.systems.DecalSaving"))
    self.world:addSystem(require("core.systems.Decals"))
    self.world:addSystem(require("core.systems.PlaneRendering"))
    self.world:addSystem(require("core.systems.ScorePoints"))
    if GLOBAL_DEBUG_ENABLED then
        self.world:addSystem(require("core.systems.debug.DebugSpeed"))
        self.world:addSystem(require("core.systems.debug.DebugCollisions"))
        self.world:addSystem(require("core.systems.debug.DebugInfo"))
        self.world:addSystem(require("core.systems.debug.DebugFrameRateGraph"))
    end
    self.world:addSystem(require("core.systems.ScreenRendering"))
    -- self.world:addSystem(require("core.systems.ReplayRecording"))
    self.world:addSystem(require("core.systems.ReplayPlayback"))
    self.world:addSystem(require("core.systems.EventCleanup"))
end

function GameManager:triggerUI(name, ...)
    if self.ui and self.ui[name] then
        self.ui[name](self.ui, ...)
    end
end

function GameManager:update(deltaTime)
    self.time = self.time + deltaTime * self.deltaTimeMultiplier
    self.world:emit("update", deltaTime * self.deltaTimeMultiplier)
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

function GameManager:initializeMenuMode()
    self.world:getSystem(require("core.systems.LevelStreaming")):setEnabled(false)
    self.world:getSystem(require("core.systems.PlayerControl")):setEnabled(false)
    self.world:getSystem(require("core.systems.CameraFollowPlayer")):setEnabled(false)
    self.world:getSystem(require("core.systems.PlayerRotation")):setEnabled(false)
    self.world:getSystem(require("core.systems.PlaneRendering")).overrideBlurLevel = 0.7
    self.world:getSystem(require("core.systems.LevelFinish")):setEnabled(false)

    self.world:addSystem(require("core.systems.menu.MenuCamera"))

    self.deltaTimeMultiplier = 0.05
end

return GameManager