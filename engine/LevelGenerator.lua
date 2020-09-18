local class = require("lib.middleclass")

local LevelGenerator = class("LevelGenerator")

function LevelGenerator:initialize(levelConfig)
    self.levelConfig = levelConfig
end

function LevelGenerator:generate()

end

return LevelGenerator