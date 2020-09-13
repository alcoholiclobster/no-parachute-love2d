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
    self.world:addSystem(require("engine.systems.CameraFollowPlayer"))
    self.world:addSystem(require("engine.systems.BoundaryLimit"))
    self.world:addSystem(require("engine.systems.DecorativePlaneCycling"))
    self.world:addSystem(require("engine.systems.PlaneRendering"))

    local count = 50
    for i = 0, count - 1 do
        local z = -100 + i * 100 / count
        Concord.entity(self.world)
            :give("position", maf.vec3(0, 0, z))
            :give("size", maf.vec3(10, 10))
            :give("rotation", math.random(1, 4)*math.pi * 0.5)
            :give("drawable")
            :give("decorativePlane")
            :give("velocity", maf.vec3(0, 0, 25))
            :give("color", 1, 1, 1)
            :give("texture", Assets.texture("level1/decorative"..math.random(1, 3)))
    end

    Concord.entity(self.world)
        :give("position", maf.vec3(0, 0, -10))
        :give("size", maf.vec3(2.5, 2.5))
        :give("rotation", 0)
        :give("drawable")
        :give("playerControlled")
        :give("velocity", maf.vec3(0, 0, 0))
        :give("color", 1, 1, 1, 1)
        :give("texture", Assets.texture("player"))

    self.camera = Concord.entity(self.world)
        :give("position", maf.vec3(0, 0, 0))
        :give("rotation", 0)
        :give("camera")
end

function Engine:update(deltaTime)
    self.world:emit("update", deltaTime)
end

function Engine:draw()
    love.graphics.clear(0, 0, 0, 1)
    self.world:emit("draw")
    love.graphics.origin()
    love.graphics.setColor(1, 1, 1, 1)

    love.graphics.print("no-parachute-ecs", 10, 10)
    love.graphics.print("fps: "..tostring(love.timer.getFPS()), 10, 30)
end

return Engine