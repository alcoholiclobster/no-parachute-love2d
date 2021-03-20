local class = require("lib.middleclass")
local BaseCutscene = require("ui.cutscenes.BaseCutscene")
local assets = require("core.assets")

local IntroCutscene = class("IntroCutscene", BaseCutscene)

function IntroCutscene:initialize(uiScreen)
    BaseCutscene.initialize(self, uiScreen)
    self.planeSound = assets.sound("plane.wav")
    self.planeSound:setLooping(true)
    self.planeSound:play()
    self.planeSound:setVolume(0.4)
    self:changeScene("intro.Scene1")
end

function IntroCutscene:onHide()
    self.planeSound:stop()
    BaseCutscene.onHide(self)
end

return IntroCutscene