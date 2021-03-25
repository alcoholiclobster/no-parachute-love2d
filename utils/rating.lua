local storage = require("utils.storage")
local rating = {}

function rating.calculateTotalRating()
    local earnedRating = 0
    local totalRating = 0

    local levelName = "intro"
    while levelName do
        local config = require("config.levels."..levelName)
        local isCompleted = storage.getLevelData(levelName, "is_completed", false)

        local ratingItems = {0, 0, 0}
        if config.highscores then
            for i, value in ipairs(config.highscores) do
                ratingItems[i + 1] = value
            end
        end

        local rating = 0
        if isCompleted then
            local highscore = storage.getLevelData(levelName, "highscore", 0)

            for i = 1, 3 do
                if highscore >= ratingItems[i] then
                    rating = i
                end
            end
        end
        earnedRating = earnedRating + rating
        totalRating = totalRating + 3

        levelName = config.nextLevel
    end

    return earnedRating, totalRating
end

function rating.calculateLevelRating(levelConfig, playerScore)
    local rating = 0
    if levelConfig.highscores then
        for i, value in ipairs(levelConfig.highscores) do
            if value > playerScore then
                break
            else
                rating = i
            end
        end
        rating = rating + 1
    elseif playerScore > 0 then
        rating = 3
    end

    return rating
end

return rating