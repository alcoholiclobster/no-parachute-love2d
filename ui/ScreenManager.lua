local class = require("lib.middleclass")

local ScreenManager = class("ScreenManager")

function ScreenManager:initialize()
    self.screen = nil

    self.fadeOutTime = 0.2
    self.fadeInTime = 0.5
    self.fadeProgress = 1
    self.fadeScreen = nil
end

function ScreenManager:emit(name, ...)
    if self.screen and self.screen[name] then
        self.screen[name](self.screen, ...)
    end
end

function ScreenManager:update(deltaTime)
    if self.fadeScreen and self.fadeProgress < 1 then
        self.fadeProgress = self.fadeProgress + deltaTime / self.fadeOutTime
        if self.fadeProgress > 1 then
            self.fadeProgress = 1
            self:show(self.fadeScreen)
            self.fadeScreen = nil
        end
    elseif not self.fadeScreen and self.fadeProgress > 0 then
        self.fadeProgress = self.fadeProgress - deltaTime / self.fadeInTime
        if self.fadeProgress < 0 then
            self.fadeProgress = 0
        end
    end
end

function ScreenManager:draw()
    if self.fadeProgress > 0 then
        love.graphics.setColor(0, 0, 0, self.fadeProgress)
        love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
    end
end

function ScreenManager:transition(screen)
    self.fadeScreen = screen
    self.fadeProgress = 0
end

function ScreenManager:show(screen)
    if self.screen then
        self.screen:onHide()
    end

    self.screen = screen

    if self.screen then
        self.screen.screenManager = self
        self.screen:onShow()
    end
end

return ScreenManager