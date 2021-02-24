local Concord = require("lib.concord")
local assets = require("core.assets")

local SoundEffects = Concord.system({
    obstaclesPassedPlayerPool = {"obstaclePassedPlayerEvent"},
    playerPool = {"controlledByPlayer", "character"}
})

local obstacleSoundInstances = {}
local lastTimePlayed = 0

local function getFreeObstacleSound()
    for i, source in ipairs(obstacleSoundInstances) do
        if not source:isPlaying() then
            return source
        end
    end

    local source = love.audio.newSource("assets/sounds/obstacle.wav", "static")
    table.insert(obstacleSoundInstances, source)
    return source
end

function SoundEffects:init()
    self.windSound = assets.sound("wind_loop.ogg")
    self.windSound:play()
    self.windSound:setLooping(true)

    self.obstacleSound = assets.sound("obstacle.wav")
end

function SoundEffects:destroy()
    self.windSound:stop()
    self.windSound = nil
end

function SoundEffects:update(deltaTime)
    local playerCharacter = self.playerPool[1]
    if not playerCharacter then
        return
    end
    local gameManager = self:getWorld().gameManager
    local velocity = playerCharacter.velocity.value
    local velocityIncrease = velocity.z / -gameManager.levelConfig.fallSpeed
    if velocityIncrease > 0 then
        self.windSound:setPitch(velocityIncrease * 0.5)
        self.windSound:setVolume(velocityIncrease * 0.8)
    else
        self.windSound:setVolume(0)
    end

    local time = love.timer.getTime()
    if time - lastTimePlayed > 0.2 then
        for _ in ipairs(self.obstaclesPassedPlayerPool) do
            local sound = getFreeObstacleSound()
            sound:play()
            sound:setVolume(0.9 * velocityIncrease)
            sound:setPitch(1.75 * velocityIncrease + math.random() * 0.5)

            lastTimePlayed = time
        end
    end
end

return SoundEffects