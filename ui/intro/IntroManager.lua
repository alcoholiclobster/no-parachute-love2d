local class = require("lib.middleclass")

local IntroManager = class("IntroManager")

function IntroManager:initialize()
    self.scene = nil

    self.sceneWidth = 128
    self.sceneHeight = 128

    self.canvas = love.graphics.newCanvas(self.sceneWidth, self.sceneHeight)
    self.canvas:setFilter("nearest", "nearest")
    self:changeScene("Scene1")
end

function IntroManager:update(deltaTime)
    if self.scene then
        self.scene:update(deltaTime)
    end
end

function IntroManager:draw()
    if self.scene then
        love.graphics.setCanvas(self.canvas)
        self.scene:draw()
        love.graphics.setCanvas()

        love.graphics.setColor(1, 1, 1, 1)
        local width, height = love.graphics.getWidth(), love.graphics.getHeight()
        local imageWidth = height * 0.8
        local imageHeight = height * 0.8
        love.graphics.draw(self.canvas, width / 2 - imageWidth / 2, height / 2 - imageHeight / 2, 0, 1 / self.sceneWidth * imageWidth)
    end
end

function IntroManager:changeScene(sceneName)
    if self.scene then
        self.scene:onHide()
    end

    if not sceneName then
        self.scene = nil
        return
    end
    local sceneClass = require("ui.intro.scenes."..sceneName)
    self.scene = sceneClass:new()
    self.scene.width = self.sceneWidth
    self.scene.height = self.sceneHeight
    self.scene.introManager = self
end

return IntroManager