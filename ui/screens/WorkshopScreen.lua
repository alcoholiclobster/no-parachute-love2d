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
local utf8 = require("utf8")
local exampleLevelConfig = require("config.exampleLevel")
local nativefs = require("lib.nativefs")

local WorkshopScreen = class("WorkshopScreen", Screen)

local isUploadInProgress = false

local function validateLevel(config)
    local errors = {}
    local isValid = true

    if type(config) ~= "table" then
        isValid = false
        table.insert(errors, "Failed to load level config")
        return
    end
    if type(config.name) ~= "string" or utf8.len(config.name) < 4 or utf8.len(config.name) > 40 then
        table.insert(errors, "Level name length must be between 4 and 40 characters")
        isValid = false
    end
    if type(config.planes) ~= "table" or #config.planes < 1 then
        table.insert(errors, "Level must contain at least one obstacle")
        isValid = false
    end
    if config.name == "Example Level" then
        table.insert(errors, "Change level name in levelConfig.json")
        isValid = false
    end
    if config.name:match("[^%w%s]") then
        table.insert(errors, "Level name must contain only english letters or numbers")
        isValid = false
    end

    return isValid, errors
end

local function uploadLevel(ugcId, levelId)
    local config, path = levelLoader.load(levelId)
    if not config then
        error("level does not exist")
    end
    local handle = Steam.UGC.startItemUpdate(Steam.utils.getAppID(), ugcId)
    Steam.UGC.setItemContent(handle, path)
    Steam.UGC.setItemTitle(handle, config.name)
    Steam.UGC.setItemDescription(handle, "Please add some description")
    Steam.UGC.setItemPreview(handle, path .. "/preview.png")
    Steam.UGC.submitItemUpdate(handle, nil, function(data, err)
        if err or data.result ~= 1 then
            error("Update failed", err, data.result)
        else
            isUploadInProgress = false
            if data.userNeedsToAcceptWorkshopLegalAgreement then
                Steam.friends.activateGameOverlayToWebPage("https://steamcommunity.com/sharedfiles/workshoplegalagreement")
            else
                Steam.friends.activateGameOverlayToWebPage("steam://url/CommunityFilePage/"..tostring(ugcId))
            end
        end
    end)

    isUploadInProgress = true
end

function WorkshopScreen:initialize()
    self.gameManager = GameManager:new(require("config.levels.tutorial"), self, true)

    self.levelsListUpdateDelay = 0
    self.subscribedCount = -1
    self.modsCount = -1

    self.levelsListScroll = 0
    self.levelsList = {}

    self.selectedLevelId = nil
    self.selectedLevelData = nil

    -- Create example level
    if not love.filesystem.getInfo("mods/example") then
        love.filesystem.createDirectory("mods/example")
        love.filesystem.write("mods/example/levelConfig.json", exampleLevelConfig.levelConfigJSON)
        love.filesystem.write("mods/example/preview.png", love.data.decode("data", "base64", exampleLevelConfig.previewImageBase64))
    end
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
            if config and name ~= "example" then
                table.insert(self.levelsList, { label = config.name .. " (mods/"..name..")" or name, level = "mods/"..name, isLocal = true })
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
        if item.level == self.selectedLevelId then
            love.graphics.setColor(130/255, 90/255, 150/255, 1)
        elseif item.isLocal then
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
    self.selectedLevelData.name = config.name or id
    self.selectedLevelData.isLocal = id:sub(1, 5) == "mods/"
    self.selectedLevelData.path = path
    self.selectedLevelData.errors = {}

    pcall(function ()
        local imageFileData = nativefs.read(path.."/preview.png")
        local fileData = love.filesystem.newFileData(imageFileData, "preview.png")
        self.selectedLevelData.image = love.graphics.newImage(love.image.newImageData(fileData))
    end)

    if self.selectedLevelData.isLocal then
        if not self.selectedLevelData.image then
            table.insert(self.selectedLevelData.errors, "Missing 640x360 preview.png image")
        elseif self.selectedLevelData.image:getWidth() ~= 640 or self.selectedLevelData.image:getHeight() ~= 360 then
            table.insert(self.selectedLevelData.errors, "Preview should be 640x360 pixels")
        end

        local isValid, messages = validateLevel(config)
        if not isValid then
            for i, msg in ipairs(messages) do
                table.insert(self.selectedLevelData.errors, msg)
            end
        end
    end

    if not self.selectedLevelData.isLocal then
        self.leaderboardView = LeaderboardView:new({
            name = id,
            type = "Global",
            title = lz("lbl_leaderboard_global"),
            limit = 10,
        })
    else
        self.leaderboardView = nil
    end

    self.selectedLevelData.errorsString = table.concat(self.selectedLevelData.errors, "\n")
end

function WorkshopScreen:uploadSelectedLevel()
    if not self.selectedLevelId or not self.selectedLevelData.isLocal then
        return
    end

    isUploadInProgress = true
    local publishedFileId = love.filesystem.read(self.selectedLevelData.path.."/id.txt")

    if publishedFileId and tonumber(publishedFileId) then
        uploadLevel(Steam.extra.parseUint64(publishedFileId), self.selectedLevelId)
    else
        Steam.UGC.createItem(Steam.utils.getAppID(), "Community", function (data, err)
            if err or data.result ~= 1 then
                print("Error when creating item")
            else
                love.filesystem.write(self.selectedLevelData.path.."/id.txt", tostring(data.publishedFileId))
                uploadLevel(data.publishedFileId, self.selectedLevelId)
            end
        end)
    end
end

function WorkshopScreen:drawLevelInfo(x, y, width, height)
    if not self.selectedLevelId then
        return
    end
    love.graphics.setColor(0, 0, 0, 0.8)
    love.graphics.rectangle("fill", x-1, y-1, width+2, height+2)

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
    love.graphics.setColor(1, 1, 1)
    if widgets.button(lz("btn_level_selection_start_game"), x, y + height - btnHeight * 1.1, width, btnHeight, false, "center") then
        self.screenManager:transition("GameScreen", self.selectedLevelId, "WorkshopScreen")
    end

    if self.leaderboardView then
        local screenWidth, screenHeight = love.graphics.getWidth(), love.graphics.getHeight()
        self.leaderboardView.x = imageX / screenWidth
        self.leaderboardView.y = (imageY + imageHeight) / screenHeight
        self.leaderboardView.width = width / screenWidth
        self.leaderboardView.height = (height - imageHeight - btnHeight) / screenHeight
        self.leaderboardView:draw()
    end

    if self.selectedLevelData.isLocal then
        love.graphics.setColor(0, 1, 0)
        widgets.label("This is a local level. You can edit and publish it.", imageX, imageY + imageHeight * 1.1, imageWidth, height * 0.03, true, "center")
        love.graphics.setColor(1, 0, 0)
        widgets.label(self.selectedLevelData.errorsString, imageX, imageY + imageHeight * 1.1 + height * 0.12, imageWidth, height * 0.03, true, "center")

        local btnHeight = height * 0.1
        love.graphics.setColor(1, 1, 1)
        local btnUploadLabel = isUploadInProgress and "UPLOADING..." or "UPLOAD TO WORKSHOP"
        if widgets.button(btnUploadLabel, x, y + height - height * 0.1 - btnHeight, imageWidth, btnHeight * 0.6, #self.selectedLevelData.errors > 0 or isUploadInProgress, "center") then
            self:uploadSelectedLevel()
        end
        if widgets.button("OPEN LEVEL FOLDER", x, y + height - height * 0.1 - btnHeight * 2, imageWidth, btnHeight * 0.6, false, "center") then
            love.system.openURL("file://"..self.selectedLevelData.path)
            love.window.minimize()
        end
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