local Concord = require("lib.concord")
local assets = require("core.assets")
local maf = require("lib.maf")

local SidePlaneTextures = Concord.system({
    levelStreamerPool = {"levelStreamer"},
    pool = {"sidePlane", "sidePlaneRespawnEvent", "position"},
})

function SidePlaneTextures:update()
    local levelStreamerEntity = self.levelStreamerPool[1]
    if not levelStreamerEntity then
        return
    end
    local levelStreamer = levelStreamerEntity.levelStreamer
    local sidePlanesIndex = levelStreamer.sidePlanesIndex
    local levelConfig = self:getWorld().gameManager.levelConfig

    for _, e in ipairs(self.pool) do
        if e.sidePlane.typeIndex < sidePlanesIndex then
            e.sidePlane.typeIndex = e.sidePlane.typeIndex + 1

            local config = levelConfig.sidePlanes[e.sidePlane.typeIndex]
            local textureIndex = 1
            if config.pattern then
                if levelStreamer.sidePlanePatternIndex > #config.pattern then
                    levelStreamer.sidePlanePatternIndex = 1
                end

                textureIndex = config.textures[config.pattern[levelStreamer.sidePlanePatternIndex]]
            else
                textureIndex = config.textures[math.random(1, #config.textures)]
            end
            local texture = assets.texture(textureIndex)
            e:give("texture", texture)
             :give("size", maf.vec3(texture:getWidth() / 128 * 10, texture:getHeight() / 128 * 10))
            if config.pattern then
                levelStreamer.sidePlanePatternIndex = levelStreamer.sidePlanePatternIndex + 1
            end
        end
    end
end

return SidePlaneTextures