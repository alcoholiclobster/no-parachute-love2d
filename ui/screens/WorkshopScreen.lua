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

    self.levelsListUpdateDelay = 1
    self.subscribedCount = -1
    self.modsCount = -1

    self.levelsListScroll = 0
    self.levelsList = {}

    self.selectedLevelId = nil
    self.selectedLevelData = nil
    -- self:refreshLevelsList()
end

function WorkshopScreen:update(deltaTime)
    self.gameManager:update(deltaTime)

    if self.levelsListUpdateDelay < 0 then
        -- Count local mods
        local modsCount = 0
        for _, _ in ipairs(love.filesystem.getDirectoryItems("/mods")) do
            modsCount = modsCount + 1
        end

        if Steam.UGC.getNumSubscribedItems() ~= self.subscribedCount or modsCount ~= self.modsCount then
            self:refreshLevelsList()
        end
        self.subscribedCount = Steam.UGC.getNumSubscribedItems()
        self.modsCount = modsCount
        self.levelsListUpdateDelay = 1
    else
        self.levelsListUpdateDelay = self.levelsListUpdateDelay - deltaTime
    end
end

function WorkshopScreen:refreshLevelsList()
    self.levelsList = {}

    -- Local
    for _, name in ipairs(love.filesystem.getDirectoryItems("/mods")) do
        local itemInfo = love.filesystem.getInfo("/mods/"..name)
        if itemInfo and itemInfo.type == "directory" then
            local config = levelLoader.load("mods/"..name)
            if config then
                table.insert(self.levelsList, { label = name, level = "mods/"..name, isLocal = true })
            end
        end
    end

    -- Installed
    for _, itemId in ipairs(Steam.UGC.getSubscribedItems()) do
        local flag = Steam.UGC.getItemState(itemId)
        if flag.installed then
            local config = levelLoader.load("workshop/"..tostring(itemId))
            table.insert(self.levelsList, { label = config.name, level = "workshop/"..tostring(itemId) })
        elseif flag.downloading then
            table.insert(self.levelsList, { label = "downloading..." })
        end
    end
end

function WorkshopScreen:drawLevelsList(x, y, width, height)
    love.graphics.setColor(1, 1, 1)
    if widgets.label("LEVELS LIST", x, y, width, height * 0.04, false, "left") then
        self.levelsListTab = "installed"
        self.levelsListScroll = 0
    end
    y = y + height * 0.06

    local list = self.levelsList

    local itemsHeight = height - height * 0.06 - height * 0.06
    local itemHeight = itemsHeight * 0.06
    local itemY = y
    local scroll = math.max(0, self.levelsListScroll * #list * itemHeight - itemsHeight * 0.5 * self.levelsListScroll)
    love.graphics.setScissor(x, y, width, itemsHeight)
    for _, item in ipairs(list) do
        local drawY = itemY - scroll
        if item.isLocal then
            love.graphics.setColor(0, 1, 0)
        else
            love.graphics.setColor(1, 1, 1)
        end
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
    local list = self.levelsListTab == "installed" and self.installedLevelsList or self.levelsList
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
    -- love.graphics.setColor(0, 0, 0, 0.4)
    -- love.graphics.rectangle("fill", x, y, width, height)

    if not self.selectedLevelId then
        return
    end

    love.graphics.setColor(1, 1, 1, 1)
    local imageWidth = width
    local imageHeight = width / 16 * 9
    local imageX = x
    local imageY = y

    if self.selectedLevelData.image then
        local sx, sy = renderingUtils.getImageScaleForNewDimensions(self.selectedLevelData.image, imageWidth, imageHeight)
        love.graphics.draw(self.selectedLevelData.image, imageX, imageY, 0, sx, sy)
    else
        love.graphics.setColor(0.5, 0.5, 0.5)
        love.graphics.rectangle("line", imageX, imageY, imageWidth, imageHeight)
        widgets.label("No preview image", imageX, imageY + imageHeight * 0.5, imageWidth, imageHeight * 0.1, true, "center")
    end

    local btnHeight = height * 0.1
    if widgets.button(lz("btn_level_selection_start_game"), x, y + height - btnHeight, width, btnHeight, false, "center") then
        self.screenManager:transition("GameScreen", self.selectedLevelId)
    end

    if self.leaderboardView then
        local screenWidth, screenHeight = love.graphics.getWidth(), love.graphics.getHeight()
        self.leaderboardView.x = imageX / screenWidth
        self.leaderboardView.y = (imageY + imageHeight) / screenHeight
        self.leaderboardView.width = width / screenWidth
        self.leaderboardView.height = (height - imageHeight - btnHeight) / screenHeight
        self.leaderboardView:draw()
    end

    -- Fields
    love.graphics.setColor(1, 1, 1)
    widgets.label(self.selectedLevelData.name, x + width * 0.03, y + width * 0.03, width * 0.94, imageHeight * 0.1, true, "center")
end

function WorkshopScreen:draw()
    self.gameManager:draw()
    local screenWidth, screenHeight = love.graphics.getWidth(), love.graphics.getHeight()

    love.graphics.setColor(0, 0, 0, 0.6)
    love.graphics.rectangle("fill", 0, 0, screenWidth, screenHeight)

    -- Buttons
    love.graphics.setColor(1, 1, 1, 1)
    local btnX, btnY, btnWidth, btnHeight = screenWidth * 0.08, screenHeight - screenHeight * 0.12, screenWidth * 0.1, screenHeight * 0.05
    if widgets.button(lz("btn_back"), btnX, btnY, btnWidth, btnHeight) then
        self.screenManager:transition("MainMenuScreen")
    end
    btnX = btnX + btnWidth + screenWidth * 0.02
    btnWidth = screenWidth * 0.2
    if widgets.button("OPEN MODS FOLDER", btnX, btnY, btnWidth, btnHeight, false, "center") then
        love.filesystem.createDirectory("mods")
        love.system.openURL("file://"..love.filesystem.getSaveDirectory().."/mods")
        love.window.minimize()
    end
    btnX = btnX + btnWidth + screenWidth * 0.02
    btnWidth = screenWidth * 0.2
    if widgets.button("OPEN WORKSHOP", btnX, btnY, btnWidth, btnHeight, false, "center") then
        Steam.friends.activateGameOverlayToWebPage("https://steamcommunity.com/app/"..tostring(Steam.utils.getAppID()).."/workshop/")
    end

    self:drawLevelsList(screenWidth * 0.08, screenHeight * 0.1, screenWidth * 0.4, screenHeight * 0.77)
    self:drawLevelInfo(screenWidth - screenWidth * 0.08 - screenWidth * 0.25, screenHeight * 0.1, screenWidth * 0.25, screenHeight * 0.77)
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