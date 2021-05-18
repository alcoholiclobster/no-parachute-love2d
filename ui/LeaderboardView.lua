local class = require("lib.middleclass")
local Steam = require("luasteam")
local widgets = require("ui.widgets")
local lz = require("utils.language").localize

local LeaderboardView = class("LeaderboardView")

function LeaderboardView:initialize(options)
    if type(options) ~= "table" then
        error("options not provided")
    end

    if type(options.name) ~= "string" then
        error("leaderboard name not provided")
    end

    self.leaderboardName = options.name
    self.leaderboardId = nil
    self.leaderboardType = "Global"
    self.title = options.title or "leaderboard_title"

    self.x = 0
    self.y = 0
    self.width = 1
    self.height = 1

    self.limitCount = options.limit or 15
    self.isLoadingCompleted = false

    if type(options.type) == "string" then
        self.leaderboardType = options.type
    end

    self.entries = {}
    local function handleEntriesDownload(items)
        self.isLoadingCompleted = true
        for i, item in ipairs(items) do
            table.insert(self.entries, {
                rank = self.leaderboardType == "Friends" and i or item.globalRank,
                name = Steam.friends.getFriendPersonaName(item.steamIDUser),
                score = item.score,
            })
        end
    end

    self.localEntry = nil

    local function handleLocalEntryDownload(items)
        if #items > 0 then
            self.localEntry = {
                rank = items[1].globalRank,
                name = Steam.friends.getFriendPersonaName(items[1].steamIDUser),
                score = items[1].score,
            }
        end
    end

    Steam.userStats.findOrCreateLeaderboard(self.leaderboardName, "Descending", "Numeric", function (data, err)
        if err then
            print("Failed to find leaderboard "..tostring(self.leaderboardName)..": "..tostring(err))
            self.isLoadingCompleted = true
            return
        end
        self.leaderboardId = data.steamLeaderboard

        -- Download entries
        if self.leaderboardType == "Global" then
            Steam.userStats.downloadLeaderboardEntries(self.leaderboardId,  self.leaderboardType, 1, self.limitCount, handleEntriesDownload)
            Steam.userStats.downloadLeaderboardEntries(self.leaderboardId,  "GlobalAroundUser", 0, 0, handleLocalEntryDownload)
        elseif self.leaderboardType == "Friends" then
            Steam.userStats.downloadLeaderboardEntries(self.leaderboardId,  self.leaderboardType, handleEntriesDownload)
        end
    end)
end

function LeaderboardView:draw()
    local screenWidth, screenHeight = love.graphics.getWidth(), love.graphics.getHeight()
    local x, y, width, height = self.x * screenWidth, self.y * screenHeight, self.width * screenWidth, self.height * screenHeight

    local itemX, itemY = x, y
    local itemWidth, itemHeight = width, height * 0.05
    love.graphics.setColor(165/255, 86/255, 125/255)
    widgets.label(self.title, itemX, itemY, itemWidth, itemHeight, true, "center")

    love.graphics.setLineWidth(itemHeight * 0.04)
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.line(itemX+2, itemY+2, itemX + itemWidth+2, itemY+2)
    love.graphics.line(itemX+2, itemY + itemHeight * 1.4+2, itemX + itemWidth+2, itemY + itemHeight * 1.4+2)

    love.graphics.setColor(130/255, 90/255, 150/255, 1)
    love.graphics.line(itemX, itemY, itemX + itemWidth, itemY)
    love.graphics.line(itemX, itemY + itemHeight * 1.4, itemX + itemWidth, itemY + itemHeight * 1.4)

    itemY = itemY + itemHeight * 1.4 + height * 0.025
    local itemsHeight = height - itemHeight * 1.4 - height * 0.025
    itemHeight = itemsHeight / (self.limitCount + 1)

    if not self.isLoadingCompleted then
        love.graphics.setColor(0.7, 0.7, 0.7)
        widgets.label(lz("lbl_leaderboard_loading"), itemX, itemY, itemWidth, itemHeight, true, "center")
        return
    end

    itemX = x + width * 0.05
    itemWidth = width * 0.9
    for i = 1, self.limitCount do
        local height = itemHeight * 0.6
        local row = self.entries[i]
        if row then
            if i == 1 then
                love.graphics.setColor(255/255, 204/255, 18/255)
            elseif i == 2 then
                love.graphics.setColor(0.9, 0.9, 0.9)
            elseif i == 3 then
                love.graphics.setColor(171/255, 89/255, 38/255)
            else
                love.graphics.setColor(0.6, 0.6, 0.6)
            end
            widgets.label(row.rank..".", itemX, itemY, itemWidth, height, false, "left")
            widgets.label(row.name, itemX + itemWidth * 0.07, itemY, itemWidth, height, false, "left")
            love.graphics.setColor(1, 1, 1)
            widgets.label(tostring(row.score), itemX, itemY, itemWidth, height, true, "right")
        else
            widgets.label("-", itemX, itemY, itemWidth, height, true, "right")
        end
        itemY = itemY + itemHeight
    end

    if self.localEntry then
        local row = self.localEntry
        love.graphics.setColor(71/255, 175/255, 255/255)
        widgets.label(row.rank..".", itemX, itemY, itemWidth, itemHeight * 0.6, false, "left")
        widgets.label(row.name, itemX + itemWidth * 0.07, itemY, itemWidth, itemHeight * 0.6, false, "left")
        love.graphics.setColor(1, 1, 1)
        widgets.label(tostring(row.score), itemX, itemY, itemWidth, itemHeight * 0.6, true, "right")
    end
end

return LeaderboardView