local class = require("lib.middleclass")

local BaseScene = class("BaseScene")

function BaseScene:initialize(cutscene)
    self.cutscene = cutscene
end

function BaseScene:update(deltaTime)

end

function BaseScene:draw()

end

function BaseScene:onHide()

end

return BaseScene