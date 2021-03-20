local class = require("lib.middleclass")
local widgets = require("ui.widgets")

local BaseCutscene = class("BaseCutscene")

function BaseCutscene:initialize(uiScreen)
    self.screen = uiScreen
    self.scene = nil

    self.sceneWidth = 128
    self.sceneHeight = 128

    self.canvas = love.graphics.newCanvas(self.sceneWidth, self.sceneHeight)
    self.canvas:setFilter("nearest", "nearest")

    self.text = nil
end

function BaseCutscene:update(deltaTime)
    if self.scene then
        self.scene:update(deltaTime)
    end
end

function BaseCutscene:draw()
    if self.scene then
        love.graphics.setCanvas(self.canvas)
        self.scene:draw()
        love.graphics.setCanvas()

        love.graphics.setColor(1, 1, 1, 1)
        local width, height = love.graphics.getWidth(), love.graphics.getHeight()
        local imageWidth = height * 0.8
        local imageHeight = height * 0.8
        love.graphics.draw(self.canvas, width / 2 - imageWidth / 2, height / 2 - imageHeight / 2, 0, 1 / self.sceneWidth * imageWidth)

        if self.text then
            local textY = height / 2 + imageHeight / 2 + height * 0.01
            widgets.label(self.text, 0, textY, width, (height - textY) * 0.6, true, "center")
        end
    end
end

function BaseCutscene:setText(text)
    self.text = text
end

function BaseCutscene:onHide()
    self:changeScene()
end

function BaseCutscene:changeScene(sceneName)
    if self.scene then
        self.scene:onHide()
    end

    if not sceneName then
        self.scene = nil
        return
    end
    local sceneClass = require("ui.cutscenes."..sceneName)
    self.scene = sceneClass:new(self)
    self.scene.width = self.sceneWidth
    self.scene.height = self.sceneHeight
end

function BaseCutscene:startGame()
    self.screen:startGame()
end

return BaseCutscene