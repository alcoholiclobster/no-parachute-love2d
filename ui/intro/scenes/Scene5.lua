local class = require("lib.middleclass")
local IntroScene = require("ui.intro.IntroScene")
local scheduler = require("utils.scheduler")
local assets = require("core.assets")
local mathUtils = require("utils.math")

local Scene3 = class("Scene3", IntroScene)

function Scene3:initialize()
    local this = self
    self.thread = scheduler.createThread(function () this:process() end)

    self.line = 0

    self.fadeIn = 0

    self.characterSpeedX = 0
    self.characterSpeedY = 0
    self.characterX = 0
    self.characterY = -128

    self.shakeX = 0
    self.shakeY = 0
    self.shakeDelay = 0

    self.gateProgress = 0
    self.isGateMoving = false
end

function Scene3:onHide()
    scheduler.killThread(self.thread)
end

function Scene3:process()
    scheduler.wait(3)
    self.isGateMoving = true
    scheduler.wait(3.5)
    self.characterSpeedY = 128
    scheduler.wait(1.5)
    self.introManager:changeScene("Scene6")
end

function Scene3:update(deltaTime)

    if self.isGateMoving then
        self.gateProgress = self.gateProgress + deltaTime / 2.5
        if self.gateProgress > 1 then
            self.gateProgress = 1
            self.isGateMoving = false
        end

        self.shakeDelay = self.shakeDelay - deltaTime
        if self.shakeDelay < 0 then
            self.shakeX = (math.random()-0.5)*(2-self.gateProgress)
            self.shakeY = (math.random()-0.5)*(2-self.gateProgress)

            self.shakeDelay = 1 / (30 - self.gateProgress * 15)
        end
    end

    if self.fadeIn < 1 then
        self.fadeIn = self.fadeIn + deltaTime / 0.25
        if self.fadeIn > 1 then
            self.fadeIn = 1
        end
    end

    self.characterX = self.characterX + self.characterSpeedX * deltaTime
    self.characterY = self.characterY + self.characterSpeedY * deltaTime
end

function Scene3:draw()
    if self.isGateMoving then
        love.graphics.translate(self.shakeX, self.shakeY)
    end
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(assets.texture("cutscenes/intro/scene5_bg"), 0, 0)

    -- local planeX = math.cos(love.timer.getTime() * 1.5) * 3 + 3 + self.planeOffset
    -- local planeY = math.sin(love.timer.getTime() * 4) * 2
    -- love.graphics.draw(assets.texture("cutscenes/intro/scene3_door_bg"), planeX, planeY)
    -- love.graphics.draw(assets.texture("cutscenes/intro/scene3_door"), planeX + 16 - 16 * self.doorProgress, planeY)
    -- love.graphics.draw(assets.texture("cutscenes/intro/scene3_plane"), planeX, planeY)

    if self.characterY > -16 then
        local b = mathUtils.clamp01(-self.characterY/16)
        b = math.floor(b / 0.2) * 0.2
        love.graphics.setColor(b, b, b, 1)
    end
    love.graphics.draw(assets.texture("cutscenes/intro/scene5_character"), self.characterX + math.sin(love.timer.getTime() * 3), self.characterY)

    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(assets.texture("cutscenes/intro/scene5_fg"), 0, 0)

    local gt = 1 - mathUtils.clamp01(math.pow(1 - self.gateProgress, 2))
    local gateAlpha = 1
    if gt > 0.9 then
        gateAlpha = 1 - (gt - 0.9) / (1 - 0.9)
    end
    love.graphics.setColor(1, 1, 1, gateAlpha)
    love.graphics.draw(assets.texture("cutscenes/intro/scene5_gate_left"), -gt * 32, 0)
    love.graphics.draw(assets.texture("cutscenes/intro/scene5_gate_right"), gt * 32, 0)

    if self.fadeIn < 1 then
        love.graphics.setColor(0, 0, 0, 1 - self.fadeIn)
        love.graphics.rectangle("fill", 0, 0, self.width, self.height)
    end
end

return Scene3