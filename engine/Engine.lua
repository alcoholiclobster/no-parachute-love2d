local class = require("lib.middleclass")
local Concord = require("lib.concord")
local maf = require("lib.maf")
local Assets = require("engine.Assets")

Concord.utils.loadNamespace("engine/components")

local Engine = class("Engine")

function Engine:initialize()
    self.world = Concord.world()

    self.world:addSystem(require("engine.systems.PlayerControl"))
    self.world:addSystem(require("engine.systems.Movement"))
    self.world:addSystem(require("engine.systems.LimbPoses"))
    self.world:addSystem(require("engine.systems.LimbAttach"))
    self.world:addSystem(require("engine.systems.CameraFollowPlayer"))
    self.world:addSystem(require("engine.systems.BoundaryLimit"))
    self.world:addSystem(require("engine.systems.DecorativePlaneCycling"))
    self.world:addSystem(require("engine.systems.ObstacleSpawn"))
    self.world:addSystem(require("engine.systems.ObstacleDestroy"))
    self.world:addSystem(require("engine.systems.PlaneRendering"))
    self.world:addSystem(require("engine.systems.debug.DebugInfo"))

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
            :give("texture", Assets.texture("level1/decorative"..math.random(1, 3)))
    end

    self:createPlayer()

    -- Camera
    Concord.entity(self.world)
        :give("position", maf.vec3(0, 0, 0))
        :give("rotation", 0)
        :give("camera")

    -- Obstacle spawner
    Concord.entity(self.world)
        :give("position", maf.vec3(0, 0, -100))
        :give("lastObstacleDistance")
end

function Engine:createPlayer()
    -- Player
    local player = Concord.entity(self.world)
        :give("position", maf.vec3(0, 0, -10))
        :give("size", maf.vec3(2.5, 2.5))
        :give("rotation", 0)
        :give("drawable")
        :give("playerControlled")
        :give("velocity", maf.vec3(0, 0, -25))
        :give("moveDirection")
        :give("texture", Assets.texture("player/torso"))

    -- Limbs
    -- Right Hand
    Concord.entity(self.world)
        :give("position")
        :give("size", maf.vec3(2.5, 2.5))
        :give("rotation", 0)
        :give("drawable")
        :give("limbParent", player)
        :give("limbRotation", 0)
        :give("limbRotationPoses", -0.2, 0.2, 0.1, -0.3)
        :give("texture", Assets.texture("player/hand"))
        :give("offset", maf.vec3(0, 0, 0))

    -- Left Hand
    Concord.entity(self.world)
        :give("position")
        :give("size", maf.vec3(-2.5, 2.5))
        :give("rotation", 0)
        :give("drawable")
        :give("limbParent", player)
        :give("limbRotation", 0)
        :give("limbRotationPoses", -0.2, 0.2, -0.1, 0.3)
        :give("texture", Assets.texture("player/hand"))
        :give("offset", maf.vec3(-0.08, 0, 0))

    -- Right Leg
    Concord.entity(self.world)
        :give("position")
        :give("size", maf.vec3(2.5, 2.5))
        :give("rotation", 0)
        :give("drawable")
        :give("limbParent", player)
        :give("limbRotation", 0)
        :give("limbRotationPoses", -0.2, 0.2, 0.2, -0.25)
        :give("texture", Assets.texture("player/leg"))
        :give("offset", maf.vec3(0, 0, 0))

    -- Left Leg
    Concord.entity(self.world)
        :give("position")
        :give("size", maf.vec3(-2.5, 2.5))
        :give("rotation", 0)
        :give("drawable")
        :give("limbParent", player)
        :give("limbRotation", 0)
        :give("limbRotationPoses", -0.2, 0.2, -0.2, 0.25)
        :give("texture", Assets.texture("player/leg"))
        :give("offset", maf.vec3(-0.08, 0, 0))
end

function Engine:update(deltaTime)
    self.world:emit("update", deltaTime)
end

function Engine:draw()
    love.graphics.clear(0, 0, 0, 1)
    self.world:emit("draw")
    love.graphics.origin()
    love.graphics.setColor(1, 1, 1, 1)
end

return Engine