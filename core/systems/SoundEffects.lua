local Concord = require("lib.concord")
local assets = require("core.assets")

local SoundEffects = Concord.system({
    obstaclesPassedPlayerPool = {"obstaclePassedPlayerEvent"},
    playerPool = {"controlledByPlayer", "character"},
    detachedLimbsPool = {"deathEvent", "limb"},
    limgDamagePool = {"damageEvent", "limb"},
    obstacleHitPool = {"controlledByPlayer", "character", "obstacleCollisionEvent"},
    obstacleBreakPool = {"breakableObstacle", "obstacleHitByEntityEvent"},
})

local soundInstances = {}

local passedSoundLastTimePlayed = 0
local obstacleBreakLastPlayedAt = 0

local function getSoundSource(name)
    if not soundInstances[name] then
        soundInstances[name] = {}
    end
    local instances = soundInstances[name]

    for i, source in ipairs(instances) do
        if not source:isPlaying() then
            return source
        end
    end

    local source = love.audio.newSource("assets/sounds/"..name, "static")
    table.insert(instances, source)
    return source
end

function SoundEffects:init()
    local world = self:getWorld()
    local levelConfig = world.gameManager.levelConfig

    if levelConfig.ambient then
        self.ambientSound = assets.sound("ambient/"..levelConfig.ambient..".wav")
        self.ambientSound:play()
        self.ambientSound:setLooping(true)
    end

    self.windSound = assets.sound("wind_loop.wav")
    self.windSound:play()
    self.windSound:setLooping(true)

    self.windClothesSound = assets.sound("wind_clothes_loop.wav")
    self.windClothesSound:play()
    self.windClothesSound:setLooping(true)

    self.obstacleSound = assets.sound("obstacle.wav")
end

function SoundEffects:handlePause(isPaused)
    if isPaused then
        self.windSound:stop()
        self.windClothesSound:stop()
    else
        self.windSound:play()
        self.windClothesSound:play()
    end
end

function SoundEffects:destroy()
    self.windSound:stop()
    self.windClothesSound:stop()
    self.windSound = nil
    self.windClothesSound = nil

    if self.ambientSound then
        self.ambientSound:stop()
        self.ambientSound = nil
    end
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
        self.windSound:setPitch(velocityIncrease * 0.75)
        self.windClothesSound:setPitch(velocityIncrease * 0.75)
        self.windSound:setVolume(velocityIncrease)
        self.windClothesSound:setVolume(velocityIncrease)
    else
        self.windSound:setVolume(0)
        self.windClothesSound:setVolume(0)
    end

    local time = love.timer.getTime()
    if time - passedSoundLastTimePlayed > 0.2 and #self.obstaclesPassedPlayerPool > 0 then
        local sound = getSoundSource("obstacle.wav")
        sound:play()
        sound:setVolume(0.9 * velocityIncrease)
        sound:setPitch(1.75 * math.pow(velocityIncrease, 2) + math.random() * 0.5)

        passedSoundLastTimePlayed = time
    end

    if #self.detachedLimbsPool > 0 then
        local index = math.random(1, 2)
        local sound = getSoundSource("limb_detach"..index..".wav")
        sound:play()
        sound:setVolume(1)
        sound:setPitch(0.75 + math.random() * 0.5)
    end

    if #self.limgDamagePool > 0 then
        local sound = getSoundSource("wall_hit.wav")
        sound:play()
        sound:setVolume(self.limgDamagePool[1].damageEvent.damage / 3)
        sound:setPitch(0.5 + math.random() * 1)
    end

    if #self.obstacleHitPool > 0 then
        local sound = getSoundSource("death_hit.wav")
        sound:play()
        sound:setPitch(0.75 + math.random() * 0.5)
    end

    if #self.obstacleBreakPool > 0 and time - obstacleBreakLastPlayedAt > 0.2 then
        local sound = getSoundSource("wall_break.wav")
        sound:play()
        sound:setPitch(0.4 + math.random() * 0.6)

        obstacleBreakLastPlayedAt = time
    end
end

return SoundEffects