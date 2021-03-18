local class = require("lib.middleclass")
local BaseScene = require("ui.cutscenes.BaseScene")
local scheduler = require("utils.scheduler")
local assets = require("core.assets")

local Scene3 = class("Scene3", BaseScene)

function Scene3:initialize()
    local this = self
    self.thread = scheduler.createThread(function () this:process() end)

    self.line = 0
    self.isPlaneMoving = false
    self.planeSpeed = 0
    self.planeOffset = 0

    self.fadeIn = 0

    self.isDoorMoving = false
    self.doorProgress = 0

    self.characterSpeedX = -9
    self.characterSpeedY = 8
    self.characterX = 27
    self.characterY = -14
end

function Scene3:onHide()
    scheduler.killThread(self.thread)
end

function Scene3:process()
    scheduler.wait(1)

    self.isDoorMoving = true
    self.isPlaneMoving = true

    scheduler.wait(2.5)
    -- self.introManager:changeScene("Scene4")
    self.cutscene:startGame()
end

function Scene3:update(deltaTime)
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
        self.planeSpeed = self.planeSpeed + 10 * deltaTime
        self.planeOffset = self.planeOffset + deltaTime * self.planeSpeed
    end

    -- self.characterSpeedX = self.characterSpeedX + 1 * deltaTime
    self.characterSpeedY = self.characterSpeedY + 54 * deltaTime
    self.characterX = self.characterX + self.characterSpeedX * deltaTime
    self.characterY = self.characterY + self.characterSpeedY * deltaTime
end

function Scene3:draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(assets.texture("cutscenes/intro/sky_bg"), 0, 0)

    local planeX = math.cos(love.timer.getTime() * 1.5) * 3 + 3 + self.planeOffset
    local planeY = math.sin(love.timer.getTime() * 4) * 2
    love.graphics.draw(assets.texture("cutscenes/intro/scene3_door_bg"), planeX, planeY)
    love.graphics.draw(assets.texture("cutscenes/intro/scene3_door"), planeX + 16 - 16 * self.doorProgress, planeY)
    love.graphics.draw(assets.texture("cutscenes/intro/scene3_plane"), planeX, planeY)

    love.graphics.draw(assets.texture("cutscenes/intro/scene3_character"), self.characterX, self.characterY)

    if self.fadeIn < 1 then
        love.graphics.setColor(0, 0, 0, 1 - self.fadeIn)
        love.graphics.rectangle("fill", 0, 0, self.width, self.height)
    end
end

return Scene3