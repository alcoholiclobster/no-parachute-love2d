local Concord = require("lib.concord")
local maf = require("lib.maf")
local mathUtils = require("utils.math")
local Assets = require("engine.Assets")

local ObstacleCollision = Concord.system({
    obstaclePool = {"obstaclePlane", "position"},
    characterPool = {"character", "position", "velocity"}
})

function ObstacleCollision:update(deltaTime)
    for _, obstacle in ipairs(self.obstaclePool) do
        for _, character in ipairs(self.characterPool) do
            if character.position.value.z + character.velocity.value.z * deltaTime < obstacle.position.value.z and
               character.position.value.z > obstacle.position.value.z
            then
                local offset = mathUtils.rotateVector2D(
                    maf.vec3(
                        character.position.value.x - obstacle.position.value.x,
                        character.position.value.y - obstacle.position.value.y
                    ),

                    -obstacle.rotation.value
                )

                local imageData = Assets.textureImageData(obstacle.texture.value)

                local tx = math.floor((offset.x + obstacle.size.value.x * 0.5) / obstacle.size.value.x * imageData:getWidth())
                local ty = math.floor((offset.y + obstacle.size.value.y * 0.5) / obstacle.size.value.y * imageData:getHeight())
                local _, _, _, alpha = imageData:getPixel(tx, ty)

                if alpha > 0 then
                    -- print("alpha at "..tostring(tx).." "..tostring(ty).." = "..tostring(alpha))
                    character.position.value.z = obstacle.position.value.z + 1
                    character.velocity.value = maf.vec3(0, 0, 0)
                    character:remove("alive")
                end
            end
        end
    end
end

return ObstacleCollision