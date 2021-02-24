local class = require("lib.middleclass")

local MusicManager = class("MusicManager")

local fadeOutTime = 0.5
local fadeInDelay = 2
local fadeInTime = 0.1

function MusicManager:initialize()
    self.source = nil

    self.currentSong = nil
    self.nextSong = nil
    self.fadeInDelay = 0

    self.maxVolume = 1
    self.isSilenced = false

    love.audio.setEffect("silenced1", {type = "compressor"})
    love.audio.setEffect("silenced2", {type = "reverb"})
end

function MusicManager:play(name)
    if self.currentSong == name then
        return
    end
    self.nextSong = name or "__stop"

    if not self.source then
        self:_playNextSong()
    end
end

function MusicManager:stop()
    self:play(nil)
end

function MusicManager:setSilenced(state)
    -- self.isSilenced = state

    -- if self.source then

    --     self.maxVolume = state and 0.1 or 1
    --     self.source:setEffect("silenced1", self.isSilenced)
    --     self.source:setEffect("silenced2", self.isSilenced)
    -- end
end

function MusicManager:_playNextSong()
    if self.source then
        self.source:stop()
        self.source = nil
    end

    if self.nextSong == "__stop" then
        self.currentSong = nil
    else
        self.source = love.audio.newSource("assets/music/"..self.nextSong..".ogg", "stream")
        self.source:setVolume(1)
        self.source:play()
        self.source:setLooping(true)
        self:setSilenced(self.isSilenced)

        self.currentSong = self.nextSong
    end

    self.nextSong = nil
    self.fadeInDelay = fadeInDelay
end

function MusicManager:update(deltaTime)
    if self.nextSong then
        local volume = self.source:getVolume() - deltaTime / fadeOutTime
        if volume > 0 then
            self.source:setVolume(volume)
        else
            self:_playNextSong()
        end
    else
        if self.fadeInDelay > 0 then
            self.fadeInDelay = self.fadeInDelay - deltaTime
            return
        end
        if self.source then
            local volume = math.min(self.maxVolume, self.source:getVolume() + deltaTime / fadeInTime)
            self.source:setVolume(volume)
        end
    end
end

return MusicManager:new()