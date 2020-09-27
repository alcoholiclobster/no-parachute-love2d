local class = require("lib.middleclass")
local tableUtils = require("utils.table")

local LevelGenerator = class("LevelGenerator")

function LevelGenerator:initialize(levelConfig)
    self.levelConfig = levelConfig
    self.obstacles = {}
end

function LevelGenerator:generate()
    self.obstacles = {}

    local previousObstacle = nil
    local previousObstacleRotations = {}

    for i = 1, self.levelConfig.obstaclesCount do
        local possibleObstacles = {}
        for _, o in ipairs(self.levelConfig.obstacles) do
            if i >= o.appearFrom and i <= o.appearTo then
                table.insert(possibleObstacles, o)
            end
        end

        if #possibleObstacles > 0 then
            if #possibleObstacles > 1 then
                local index = tableUtils.indexOf(possibleObstacles, previousObstacle)
                if index then
                    table.remove(possibleObstacles, index)
                end
            end
            local nextObstacle = possibleObstacles[math.random(1, #possibleObstacles)]

            if nextObstacle.requiredFreeSpace and nextObstacle.requiredFreeSpace > 0 then
                local freeSpace = nextObstacle.requiredFreeSpace
                if previousObstacle.isWide then
                    freeSpace = freeSpace - 1
                end
                if freeSpace > 0 then
                    table.insert(self.obstacles, { freeSpace = freeSpace })
                end
            end

            local rotationDirection = math.random(1, 4)
            if previousObstacleRotations[nextObstacle] and previousObstacleRotations[nextObstacle] == rotationDirection then
                rotationDirection = rotationDirection + 1
            end

            table.insert(self.obstacles, {
                planes = nextObstacle.planes,
                rotation = rotationDirection * math.pi / 2,
            })

            previousObstacleRotations[nextObstacle] = rotationDirection
            previousObstacle = nextObstacle
        end
    end
end

return LevelGenerator