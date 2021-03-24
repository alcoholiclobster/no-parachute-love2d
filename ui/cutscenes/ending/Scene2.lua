local class = require("lib.middleclass")
local BaseScene = require("ui.cutscenes.BaseScene")
local scheduler = require("utils.scheduler")
local assets = require("core.assets")

local Scene2 = class("Scene2", BaseScene)

function Scene2:initialize(cutscene)
    BaseScene.initialize(self, cutscene)

    local this = self
    self.thread = scheduler.createThread(function () this:process() end)

    self.line = 0
    self.isPlaneMoving = true
    self.planeSpeed = 30
    self.planeOffset = -102

    self.fadeIn = 0

    self.isDoorMoving = false
    self.doorProgress = 0

    self.gravity = 1
    self.characterSpeedX = 0
    self.characterSpeedY = 0
    self.characterX = 64
    self.characterY = 140
    self.characterRotation = 0
    self.time = 0

    self.hitSound = assets.sound("wall_hit.wav")
    self.cutscene.planeSound:play()
end

function Scene2:onHide()
    scheduler.killThread(self.thread)
end

function Scene2:process()
    scheduler.wait(1)
    self.characterSpeedY = -70

    scheduler.wait(1.5)
    self.isDoorMoving = true

    self.doorSound = assets.sound("plane_door.wav")
    scheduler.wait(0.3)
    self.doorSound:play()

    scheduler.wait(5)
    self.cutscene:stop()
end

function Scene2:update(deltaTime)
    self.time = self.time + deltaTime
    if self.isDoorMoving and self.doorProgress < 1 then
        self.doorProgress = self.doorProgress + deltaTime * 2
        if self.doorProgress > 1 then
            self.doorProgress = 1
        end
    end

    if self.fadeIn < 1 then
        self.fadeIn = self.fadeIn + deltaTime / 0.25
        if self.fadeIn > 1 then
            self.fadeIn = 1
        end
    end

    if self.isPlaneMoving then
        self.planeOffset = self.planeOffset + deltaTime * self.planeSpeed
    end

    self.characterSpeedY = self.characterSpeedY + self.gravity * deltaTime
    self.characterX = self.characterX + self.characterSpeedX * deltaTime
    self.characterY = self.characterY + self.characterSpeedY * deltaTime

    if self.characterY < 35 then
        if self.gravity ~= 0 then
            self.hitSound:play()
        end

        self.characterSpeedY = 0
        self.gravity = 0
        self.characterSpeedX = self.planeSpeed
    end
end

function Scene2:draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(assets.texture("cutscenes/intro/sky_bg"), 0, 0)

    local planeX = math.cos(love.timer.getTime() * 1.5) * 3 + 3 + self.planeOffset
    local planeY = math.sin(love.timer.getTime() * 4) * 2
    love.graphics.draw(assets.texture("cutscenes/intro/Scene3_door_bg"), planeX, planeY)

    if self.isDoorMoving then
        love.graphics.draw(assets.texture("cutscenes/ending/character"), self.characterX, self.characterY, self.characterRotation, 1, 1, 8, 8)
    end

    love.graphics.draw(assets.texture("cutscenes/intro/Scene3_door"), planeX + 16 - 16 * self.doorProgress, planeY)
    love.graphics.draw(assets.texture("cutscenes/intro/Scene3_plane"), planeX, planeY)

    if not self.isDoorMoving then
        self.characterRotation = math.floor(self.time * 3 * 5) / 5
        love.graphics.draw(assets.texture("cutscenes/ending/character"), self.characterX, self.characterY, self.characterRotation, 1, 1, 8, 8)
    end
    if self.fadeIn < 1 then
        love.graphics.setColor(0, 0, 0, 1 - self.fadeIn)
        love.graphics.rectangle("fill", 0, 0, self.width, self.height)
    end
end

return Scene2