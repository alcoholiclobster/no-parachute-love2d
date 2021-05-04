local class = require("lib.middleclass")
local Screen = require("ui.Screen")
local widgets = require("ui.widgets")
local GameManager = require("core.GameManager")
local lz = require("utils.language").localize
local Steam = require("luasteam")

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
    self.subscribedCheckDelay = 0
    self.subscribedCount = -1
end

function WorkshopScreen:update(deltaTime)
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

function WorkshopScreen:draw()
    local screenWidth, screenHeight = love.graphics.getWidth(), love.graphics.getHeight()

    if updateHandle then
        local status = Steam.UGC.getItemUpdateProgress(updateHandle)
        widgets.label("update status: "..tostring(status), screenWidth * 0.1, screenHeight * 0.5, screenWidth * 0.5, screenHeight * 0.05)
    end

    -- Back to menu screen button
    if widgets.button(lz("btn_back"), screenWidth * 0.08, screenHeight - screenHeight * 0.1, screenWidth * (0.5 - 0.08 * 2), screenHeight * 0.05) then
        self.screenManager:transition("MainMenuScreen")
    end

    if widgets.button("[open mods folder]", screenWidth * (0.7 - 0.04), screenHeight - screenHeight * 0.2, screenWidth * 0.3, screenHeight * 0.05, false, "right") then
        love.filesystem.createDirectory("mods")
        love.system.openURL("file://"..love.filesystem.getSaveDirectory().."/mods")
    end

    if widgets.button("[test upload]", screenWidth * (0.7 - 0.04), screenHeight - screenHeight * 0.1, screenWidth * 0.3, screenHeight * 0.05, false, "right") then
        local modRoot = "mods/"..localModName
        local id = love.filesystem.read(modRoot.."/id.txt")

        if id and tonumber(id) then
            print("found id", id)
            populateItem(Steam.extra.parseUint64(id))
        else
            Steam.UGC.createItem(Steam.utils.getAppID(), "Community", function (data, err)
                if err or data.result ~= 1 then
                    print("Error when creating item")
                else
                    love.filesystem.write(modRoot.."/id.txt", tostring(data.publishedFileId))
                    populateItem(data.publishedFileId)
                end
            end)
        end
    end
end

return WorkshopScreen