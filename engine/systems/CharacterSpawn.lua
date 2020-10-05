local Concord = require("lib.concord")
local maf = require("lib.maf")
local assets = require("engine.assets")
local charactersConfig = require("config.characters")

local CharacterSpawn = Concord.system({
    pool = {"characterSpawnRequest"}
})

function CharacterSpawn:update(deltaTime)
    local gameManager = self:getWorld().gameManager
    for _, e in ipairs(self.pool) do
        local conf = charactersConfig[e.characterSpawnRequest.characterType]
        if not conf then
            error("Unknown character type \""..tostring(e.characterSpawnRequest.characterType).."\"")
        end

        -- Character body
        local characterBody = Concord.entity(self:getWorld())
            :give("name", "character")
            :give("position", maf.vec3(0, 0, -10))
            :give("size", maf.vec3(conf.body.size.x, conf.body.size.y))
            :give("rotation", 0)
            :give("velocity", maf.vec3(0, 0, -gameManager.levelConfig.fallSpeed))
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

        -- Limbs
        for limbName, limbConf in pairs(conf.limbs) do
            Concord.entity(self:getWorld())
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
        end

        if e.characterSpawnRequest.controlledByPlayer then
            characterBody:give("controlledByPlayer")
        end
    end
end

return CharacterSpawn