local class = require("lib.middleclass")
local BaseCutscene = require("ui.cutscenes.BaseCutscene")
local assets = require("core.assets")

local EndingCutscene = class("EndingCutscene", BaseCutscene)

function EndingCutscene:initialize(uiScreen)
    BaseCutscene.initialize(self, uiScreen)
    self.planeSound = assets.sound("plane.wav")
    self.planeSound:setLooping(true)
    self.planeSound:play()
    self.planeSound:setVolume(0.4)
    self:changeScene("ending.Scene1")
end

function EndingCutscene:onHide()
    self.planeSound:stop()
    BaseCutscene.onHide(self)
end

function EndingCutscene:onFinish()
    self.screen:handleCutsceneFinish()
end

return EndingCutscene