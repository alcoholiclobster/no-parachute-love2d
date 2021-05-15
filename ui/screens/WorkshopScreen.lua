local class = require("lib.middleclass")
local Screen = require("ui.Screen")
local GameManager = require("core.GameManager")
local widgets = require("ui.widgets")
local lz = require("utils.language").localize
local Steam = require("luasteam")
local levelLoader = require("core.levelLoader")
local mathUtils = require("utils.math")
local renderingUtils = require("utils.rendering")
local LeaderboardView = require("ui.LeaderboardView")

local WorkshopScreen = class("WorkshopScreen", Screen)

local localModName = "test"
local updateHandle = nil

local function populateItem(id)
    local rootFolder = love.filesystem.getSaveDirectory().."/mods/"..localModName
    local handle = Steam.UGC.startItemUpdate(Steam.utils.getAppID(), id)
    print(handle)
    Steam.UGC.setItemContent(handle, rootFolder)
    Steam.UGC.setItemTitle(handle, "My Item")
    Steam.UGC.setItemDescription(handle, "A Workshop item")
    Steam.UGC.setItemPreview(handle, rootFolder .. "/preview.png")
    Steam.UGC.submitItemUpdate(handle, "Just testing", function(data, err)
        if err or data.result ~= 1 then
            print("Update failed", err, data.result)
        else
            print("Update successfull")
            updateHandle = nil
        end
    end)

    updateHandle = handle
end

function WorkshopScreen:initialize()
    self.gameManager = GameManager:new(require("config.levels.tutorial"), self, true)

    self.subscribedCheckDelay = 0
    self.subscribedCount = -1

    self.levelsListScroll = 0
    self.levelsListTab = "installed"
    self.localLevelsList = {}
    self.installedLevelsList = {}

    self.selectedLevelId = nil
    self.selectedLevelData = nil

    self:refreshLevelsLists()
end

function WorkshopScreen:update(deltaTime)
    self.gameManager:update(deltaTime)

    if self.subscribedCheckDelay < 0 then
        if Steam.UGC.getNumSubscribedItems() ~= self.subscribedCount then
            self.subscribedCount = Steam.UGC.getNumSubscribedItems()
            print("You are subscribed to " .. self.subscribedCount .. " items")
        end

        self.subscribedCheckDelay = 1
    else
        self.subscribedCheckDelay = self.subscribedCheckDelay - deltaTime
    end
end

function WorkshopScreen:refreshLevelsLists()
    self.localLevelsList = {}
    self.installedLevelsList = {}

    -- Local
    for _, name in ipairs(love.filesystem.getDirectoryItems("/mods")) do
        local itemInfo = love.filesystem.getInfo("/mods/"..name)
        if itemInfo and itemInfo.type == "directory" then
            local config = levelLoader.load("mods/"..name)
            if config then
                table.insert(self.localLevelsList, { label = name, level = "mods/"..name })
            end
        end
    end

    -- Installed
    for _, itemId in ipairs(Steam.UGC.getSubscribedItems()) do
        local flag = Steam.UGC.getItemState(itemId)
        if flag.installed then
            local config = levelLoader.load("workshop/"..tostring(itemId))
            table.insert(self.installedLevelsList, { label = config.name, level = "workshop/"..tostring(itemId) })
        elseif flag.downloading then
            table.insert(self.installedLevelsList, { label = "downloading..." })
        end
    end
end

function WorkshopScreen:drawLevelsList(x, y, width, height)
    love.graphics.setColor(0, 0, 0, 0.4)
    love.graphics.rectangle("fill", x - width * 0.01, y, width + width * 0.02, height)

    love.graphics.setColor(1, 1, 1)

    if widgets.button("Installed levels", x, y, width * 0.5, height * 0.05, self.levelsListTab == "installed", "center") then
        self.levelsListTab = "installed"
        self.levelsListScroll = 0
    end
    if widgets.button("My levels", x + width * 0.5, y, width * 0.5, height * 0.05, self.levelsListTab == "local", "center") then
        self.levelsListTab = "local"
        self.levelsListScroll = 0
    end

    y = y + height * 0.06

    local list = self.levelsListTab == "installed" and self.installedLevelsList or self.localLevelsList

    local itemsHeight = height - height * 0.06 - height * 0.06
    local itemHeight = itemsHeight * 0.06
    local itemY = y
    local scroll = math.max(0, self.levelsListScroll * #list * itemHeight - itemsHeight * 0.5 * self.levelsListScroll)
    love.graphics.setScissor(x, y, width, itemsHeight)
    for _, item in ipairs(list) do
        local drawY = itemY - scroll
        if drawY > y - 5 and drawY < y + itemsHeight and widgets.button(item.label, x, drawY, width, itemHeight * 0.8, not item.level, "left") then
            self:selectLevel(item.level)
        end

        itemY = itemY + itemHeight
    end
    if #list == 0 then
        love.graphics.setColor(0.5, 0.5, 0.5, 1)
        widgets.label("No items", x, y + itemsHeight * 0.5, width, itemHeight * 0.8, false, "center")
    end
    love.graphics.setScissor()
end

function WorkshopScreen:handleMouseScroll(scroll)
    local list = self.levelsListTab == "installed" and self.installedLevelsList or self.localLevelsList
    if scroll > 0 then
        self.levelsListScroll = self.levelsListScroll - 1/#list*5
    elseif scroll < 0 then
        self.levelsListScroll = self.levelsListScroll + 1/#list*5
    end
    self.levelsListScroll = mathUtils.clamp01(self.levelsListScroll)
end

function WorkshopScreen:selectLevel(id)
    self.selectedLevelId = id
    local config, path = levelLoader.load(id)
    self.selectedLevelData = {}
    self.selectedLevelData.name = config.name

    pcall(function ()
        local imageFile = assert(io.open(path .. "/preview.png", "rb"))
        local imageFileData = imageFile:read("*all")
        imageFile:close()
        local fileData = love.filesystem.newFileData(imageFileData, "preview.png")
        self.selectedLevelData.image = love.graphics.newImage(love.image.newImageData(fileData))
    end)

    self.leaderboardView = LeaderboardView:new({
        name = id,
        type = "Global",
        title = lz("lbl_leaderboard_global"),
        limit = 10,
    })

    self.leaderboardView.waitingToSetPos = true
end

function WorkshopScreen:drawLevelInfo(x, y, width, height)
    love.graphics.setColor(0, 0, 0, 0.4)
    love.graphics.rectangle("fill", x, y, width, height)

    if not self.selectedLevelId then
        love.graphics.setColor(0.5, 0.5, 0.5)
        widgets.label("Select level", x, y + height * 0.48, width, height * 0.04, true, "center")
        return
    end

    love.graphics.setColor(1, 1, 1, 1)
    local imageSize = width * 0.4
    local imageX = x + width - imageSize
    local imageY = y

    if self.selectedLevelData.image then
        local sx, sy = renderingUtils.getImageScaleForNewDimensions(self.selectedLevelData.image, imageSize, imageSize)
        love.graphics.draw(self.selectedLevelData.image, imageX, imageY, 0, sx, sy)
    else
        love.graphics.setColor(0.5, 0.5, 0.5)
        love.graphics.rectangle("line", imageX, imageY, imageSize, imageSize)
        widgets.label("No preview image", imageX, imageY + imageSize * 0.5, imageSize, imageSize * 0.1, true, "center")
    end

    if self.leaderboardView then
        if self.leaderboardView.waitingToSetPos then
            self.leaderboardView.waitingToSetPos = false
            local screenWidth, screenHeight = love.graphics.getWidth(), love.graphics.getHeight()

            self.leaderboardView.x = imageX / screenWidth
            self.leaderboardView.y = (imageY + imageSize) / screenHeight
            self.leaderboardView.width = imageSize / screenWidth
            self.leaderboardView.height = (height - imageSize) / screenHeight - 0.01
        else
            self.leaderboardView:draw()
        end
    end

    -- Fields
    local fieldX = x + width * 0.02
    local fieldY = y + width * 0.02
    local fieldWidth = (width - imageSize) - width * 0.04
    local fieldHeight = height * 0.05
    love.graphics.setColor(1, 1, 1)
    widgets.label(self.selectedLevelData.name, fieldX, fieldY, fieldWidth, fieldHeight, true, "center")
    fieldY = fieldY + fieldHeight * 3
    fieldHeight = height * 0.03
    widgets.label("Author: NONAME", fieldX, fieldY, fieldWidth, fieldHeight, true, "center")
end

function WorkshopScreen:draw()
    self.gameManager:draw()
    local screenWidth, screenHeight = love.graphics.getWidth(), love.graphics.getHeight()

    love.graphics.setColor(0, 0, 0, 0.6)
    love.graphics.rectangle("fill", 0, 0, screenWidth, screenHeight)

    -- Back to menu screen button
    local btnX, btnY, btnWidth, btnHeight = screenWidth * 0.08, screenHeight - screenHeight * 0.12, screenWidth * 0.1, screenHeight * 0.05
    if widgets.button(lz("btn_back"), btnX, btnY, btnWidth, btnHeight) then
        self.screenManager:transition("MainMenuScreen")
    end
    btnX = btnX + btnWidth
    btnWidth = screenWidth * 0.15
    if widgets.button("REFRESH MODS", btnX, btnY, btnWidth, btnHeight, false, "center") then
        self:refreshLevelsLists()
    end
    btnX = btnX + btnWidth + screenWidth * 0.02
    btnWidth = screenWidth * 0.2
    if widgets.button("OPEN MODS FOLDER", btnX, btnY, btnWidth, btnHeight, false, "center") then
        love.filesystem.createDirectory("mods")
        love.system.openURL("file://"..love.filesystem.getSaveDirectory().."/mods")
        love.window.minimize()
    end

    self:drawLevelsList(screenWidth * 0.08, screenHeight * 0.1, screenWidth * 0.3, screenHeight * 0.77)
    self:drawLevelInfo(screenWidth * 0.08 + screenWidth * 0.3 + screenWidth * 0.08, screenHeight * 0.1, screenWidth - (screenWidth * 0.08 + screenWidth * 0.3 + screenWidth * 0.08) - screenWidth * 0.08, screenHeight * 0.77)
    -- if updateHandle then
    --     local status = Steam.UGC.getItemUpdateProgress(updateHandle)
    --     widgets.label("update status: "..tostring(status), screenWidth * 0.1, screenHeight * 0.05, screenWidth * 0.5, screenHeight * 0.05)
    -- end

    -- if widgets.button("[open mods folder]", screenWidth * (0.7 - 0.04), screenHeight - screenHeight * 0.2, screenWidth * 0.3, screenHeight * 0.05, false, "right") then
        -- love.filesystem.createDirectory("mods")
        -- love.system.openURL("file://"..love.filesystem.getSaveDirectory().."/mods")
    -- end

    -- if widgets.button("[play test level]", screenWidth * (0.7 - 0.04), screenHeight - screenHeight * 0.3, screenWidth * 0.3, screenHeight * 0.05, false, "right") then
    --     self:loadLocalLevel("test")
    -- end

    -- if widgets.button("[test upload]", screenWidth * (0.7 - 0.04), screenHeight - screenHeight * 0.1, screenWidth * 0.3, screenHeight * 0.05, false, "right") then
    --     local modRoot = "mods/"..localModName
    --     local id = love.filesystem.read(modRoot.."/id.txt")

    --     if id and tonumber(id) then
    --         print("found id", id)
    --         populateItem(Steam.extra.parseUint64(id))
    --     else
    --         Steam.UGC.createItem(Steam.utils.getAppID(), "Community", function (data, err)
    --             if err or data.result ~= 1 then
    --                 print("Error when creating item")
    --             else
    --                 love.filesystem.write(modRoot.."/id.txt", tostring(data.publishedFileId))
    --                 populateItem(data.publishedFileId)
    --             end
    --         end)
    --     end
    -- end

    -- local x = screenWidth * 0.05
    -- local y = screenHeight * 0.1
    -- local w = screenWidth * 0.4
    -- local h = screenHeight * 0.04
    -- for _, itemId in ipairs(Steam.UGC.getSubscribedItems()) do
    --     local id = tostring(itemId)
    --     local flag = Steam.UGC.getItemState(itemId)
    --     local text = ""
    --     if flag.installed then
    --         local success, sizeOnDisk, folder = Steam.UGC.getItemInstallInfo(itemId)
    --         text = id.." [installed] "..sizeOnDisk
    --     elseif flag.downloading then
    --         text = id.." [downloading]"
    --     else
    --         text = id.." [???]"
    --     end
    --     if widgets.button(text, x, y, w, h) then
    --         self.screenManager:transition("GameScreen", "workshop/"..id)
    --     end
    --     y = y + h * 1.5
    -- end

    -- x = screenWidth * 0.5
    -- y = screenHeight * 0.1
    -- w = screenWidth * 0.4
    -- h = screenHeight * 0.04
    -- for i, name in ipairs(self.localLevels) do
    --     if widgets.button(name, x, y, w, h) then
    --         self.screenManager:transition("GameScreen", "mods/"..name)
    --     end
    --     y = y + h * 1.5
    -- end
end

return WorkshopScreen