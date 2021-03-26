local Concord = require("lib.concord")
local maf = require("lib.maf")
local assets = require("core.assets")
local charactersConfig = require("config.characters")
local settings = require("utils.settings")

local CharacterSpawn = Concord.system({
    pool = {"characterSpawnRequest"}
})

function CharacterSpawn:update(deltaTime)
    for _, e in ipairs(self.pool) do
        e:destroy()

        local conf = charactersConfig[e.characterSpawnRequest.characterType]
        if not conf then
            error("Unknown character type \""..tostring(e.characterSpawnRequest.characterType).."\"")
        end

        local spawnPosition = maf.vec3(0, 0, 0)
        if e.position then
            spawnPosition = e.position.value:clone()
        end

        -- Character body
        local isCharacterTransparent = not not settings.get("character_transparency") and not self:getWorld().isMenuBackground
        local characterBody = Concord.entity(self:getWorld())
            :give("name", "character")
            :give("position", maf.vec3(0, 0, -8) + spawnPosition)
            :give("size", maf.vec3(conf.body.size.x, conf.body.size.y))
            :give("rotation", 0)
            :give("velocity", maf.vec3(0, 0, -self:getWorld().gameState.fallSpeed))
            :give("acceleration", conf.acceleration)
            :give("friction", conf.friction)
            :give("texture", assets.texture(conf.body.texture))
            :give("levelProgress", 0)
            :give("moveDirection")
            :give("drawable")
            :give("canCollideWithObstacles")
            :give("canCollideWithBoundaries")
            :give("character")
            :give("alive")
            :give("score", 0)

        if isCharacterTransparent then
            characterBody:give("color", 1, 1, 1, 0.5)
        end

        -- Limbs
        for limbName, limbConf in pairs(conf.limbs) do
            local limb = Concord.entity(self:getWorld())
                :give("name", limbName)
                :give("position")
                :give("size", maf.vec3(limbConf.size.x, limbConf.size.y))
                :give("rotation", 0)
                :give("attachToEntity", characterBody)
                :give("attachRotation", 0)
                :give("attachOffset",
                    maf.vec3(limbConf.offset.x, limbConf.offset.y, limbConf.offset.z))
                :give("limbRotationPoses",
                    limbConf.rotationPoses.left, limbConf.rotationPoses.right,
                    limbConf.rotationPoses.up, limbConf.rotationPoses.down)
                :give("texture", assets.texture(limbConf.textures.normal))
                :give("limbMissingTexture", assets.texture(limbConf.textures.destroyed))
                :give("obstacleCollisionCheckOffset",
                    maf.vec3(limbConf.collisionOffset.x, limbConf.collisionOffset.y, limbConf.collisionOffset.z))
                :give("drawable")
                :give("canCollideWithObstacles")
                :give("canCollideWithBoundaries")
                :give("alive")
                :give("limb")
                :give("health", 20)

            if isCharacterTransparent  then
                limb:give("color", 1, 1, 1, 0.4)
            end
        end

        if e.characterSpawnRequest.controlledByPlayer then
            characterBody:give("controlledByPlayer")
        else
            characterBody
                :give("controlledByAI")
                :give("position", maf.vec3((math.random() - 0.5) * 8, (math.random() - 0.5) * 5, 1))
                :give("rotation", math.random() * math.pi * 2)
                :give("rotationSpeed", (math.random() - 0.5) * 2)
        end
    end
end

return CharacterSpawn