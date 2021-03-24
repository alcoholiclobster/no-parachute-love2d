local class = require("lib.middleclass")
local Screen = require("ui.Screen")
local assets = require("core.assets")
local widgets = require("ui.widgets")
local lz = require("utils.language").localize

local CreditsScreen = class("CreditsScreen", Screen)

function CreditsScreen:initialize()
    self.logoImage = assets.texture("logo")
    self.isInitializationFinished = false

    self.backgroundEffect = love.graphics.newShader([[
        extern float screenWidth;
        extern float screenHeight;
        vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 pixel_coords)
        {
            vec4 texel = mix(
                vec4(137.0/255.0, 70.0/255.0, 103.0/255.0, 1),
                vec4(130.0/255.0, 90.0/255.0, 150.0/255.0, 1),
                pixel_coords.x / screenWidth
            );
            texel = mix(texel, vec4(71.0/255.0, 60.0/255.0, 111.0/255.0, 1.0), pixel_coords.y / screenHeight);
            return texel;
        }
    ]])

end

function CreditsScreen:draw()
    local screenWidth, screenHeight = love.graphics.getWidth(), love.graphics.getHeight()
    self.backgroundEffect:send("screenWidth", screenWidth)
    self.backgroundEffect:send("screenHeight", screenHeight)

    love.graphics.clear(0.1, 0.1, 0.1)
    love.graphics.setColor(1, 1, 1)
    love.graphics.setShader(self.backgroundEffect)
    love.graphics.rectangle("fill", 0, 0, screenWidth, screenHeight)
    love.graphics.setShader()

    if widgets.button(lz("btn_game_exit_to_menu"), screenWidth * 0.08, screenHeight - screenHeight * 0.1, screenWidth * (0.5 - 0.08 * 2), screenHeight * 0.05) then
        self.screenManager:transition("MainMenuScreen")
    end

    local offset = -screenHeight * 0.125
    local logoScale = math.min(screenWidth * 0.004, screenHeight * 0.004)
    local logoX = screenWidth * 0.5
    local logoY = screenHeight * 0.4 + offset
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(self.logoImage, logoX, logoY, 0, logoScale, logoScale, self.logoImage:getWidth() * 0.5, self.logoImage:getHeight() * 0.5)

    widgets.label(lz("lbl_credis"), 0, screenHeight * 0.65 + offset, screenWidth, screenHeight * 0.025, false, "center")
end

function CreditsScreen:update(deltaTime)

end

function CreditsScreen:handleInitializationFinish()
    self.isInitializationFinished = true
end

return CreditsScreen