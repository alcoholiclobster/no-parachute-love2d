local class = require("lib.middleclass")

local ScreenManager = class("ScreenManager")

function ScreenManager:initialize()
    self.screen = nil
end

function ScreenManager:emit(name, ...)
    if self.screen and self.screen[name] then
        self.screen[name](self.screen, ...)
    end
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