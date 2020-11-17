local class = require("lib.middleclass")
local IntroScene = require("ui.intro.IntroScene")
local scheduler = require("utils.scheduler")
local assets = require("core.assets")

local Scene2 = class("Scene1", IntroScene)

function Scene2:initialize()
    local this = self
    self.thread = scheduler.createThread(function () this:process() end)

    self.line = 0

    self.gravity = 0
    self.jumpSpeed = 0
    self.jumpOffset = 0

    self.isJumping = false
    self.fade = 0
end

function Scene2:process()
    scheduler.wait(2)
    self.line = 1
    scheduler.wait(1)
    while true do
        if not self.isJumping and love.keyboard.isDown("x") then
            self.isJumping = true
            self.line = 0
            self.gravity = 250
            self.jumpSpeed = 0
            break
        end
        scheduler.wait(0)
    end

    while true do
        if self.fade > 0.9 then
            self.introManager:changeScene("Scene3")
        end
        scheduler.wait(0)
    end
end

function Scene2:onHide()
    scheduler.killThread(self.thread)
end

function Scene2:update(deltaTime)
    if self.isJumping then
        self.jumpOffset = self.jumpOffset + self.jumpSpeed * deltaTime
        self.jumpSpeed = self.jumpSpeed + self.gravity * deltaTime

        self.fade = self.fade + deltaTime * 1.2
    end
end

function Scene2:draw()
    love.graphics.clear(102/255, 102/255, 102/255, 1)

    local characterY = math.sin(-love.timer.getTime() * 3) * 1 + 2 + self.jumpOffset
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(assets.texture("cutscenes/intro/scene2_glass"), 0, characterY)

    love.graphics.setColor(1, 1, 1, 0.8)
    love.graphics.draw(assets.texture("cutscenes/intro/sky_bg"), 0, characterY)

    love.graphics.setColor(1, 1, 1, 1)
    local px1 = (-love.timer.getTime() * 8) % 128
    local py1 = math.sin(love.timer.getTime() * 2 - 1) * 1 + characterY
    love.graphics.draw(assets.texture("cutscenes/intro/scene2_reflection_rocks"), px1, py1)
    love.graphics.draw(assets.texture("cutscenes/intro/scene2_reflection_rocks"), px1-128, py1)

    local px2 = (-love.timer.getTime() * 16) % 128
    local py2 = math.sin(love.timer.getTime() * 2) * 1 + characterY
    love.graphics.draw(assets.texture("cutscenes/intro/scene2_reflection"), px2, py2)
    love.graphics.draw(assets.texture("cutscenes/intro/scene2_reflection"), px2-128, py2)

    love.graphics.setColor(1, 1, 1, 0.8)
    love.graphics.draw(assets.texture("cutscenes/intro/scene2_glass"), 0, characterY)

    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(assets.texture("cutscenes/intro/scene2_character"), 0, characterY)
    love.graphics.draw(assets.texture("cutscenes/intro/scene2_plane_part"), 0, 0)

    if self.line == 1 then
        love.graphics.draw(assets.texture("cutscenes/intro/press_x_to_jump"), 0, 0)
    end

    if self.fade > 0 then
        love.graphics.setColor(0, 0, 0, self.fade)
        love.graphics.rectangle("fill", 0, 0, self.width, self.height)
    end
end

return Scene2