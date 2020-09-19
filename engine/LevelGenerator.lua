local class = require("lib.middleclass")

local LevelGenerator = class("LevelGenerator")

function LevelGenerator:initialize(levelConfig)
    self.levelConfig = levelConfig
    self.obstacles = {}
end

function LevelGenerator:generate()
    self.obstacles = {}

    local previousObstacle = nil

    for i = 1, self.levelConfig.obstaclesCount do
        local possibleObstacles = {}
        for _, o in ipairs(self.levelConfig.obstacles) do
            if i >= o.appearFrom and i <= o.appearTo then
                table.insert(possibleObstacles, o)
            end
        end

        if #possibleObstacles > 0 then
            local nextObstacle = possibleObstacles[math.random(1, #possibleObstacles)]

            if nextObstacle.requiredFreeSpace and nextObstacle.requiredFreeSpace > 0 then
                for j = 1, nextObstacle.requiredFreeSpace do
                    table.insert(self.obstacles, false)
                end
            end

            local rotationDirection = math.random(1, 4)
            if previousObstacle == nextObstacle then
                rotationDirection = rotationDirection + 1
            end

            table.insert(self.obstacles, {
                plane = nextObstacle,
                rotation = rotationDirection * math.pi / 2,
            })

            previousObstacle = nextObstacle
        end
    end
end

return LevelGenerator