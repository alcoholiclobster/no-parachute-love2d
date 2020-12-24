local Concord = require("lib.concord")
local bitser = require("lib.bitser")

local ReplayRecording = Concord.system({
    recordedEntitiesPool = {"replayRecorder", "position", "rotation", "velocity", "drawable"}
})

function ReplayRecording:update(deltaTime)
    local time = love.timer.getTime()

    for _, e in ipairs(self.recordedEntitiesPool) do
        local recorder = e.replayRecorder
        if not recorder.recordingStartedAt then
            recorder.recordingStartedAt = time
        end

        if time - recorder.lastDataTime > 0.02 then
            table.insert(recorder.data, {
                time - recorder.recordingStartedAt,
                e.position.value.x, e.position.value.y, e.position.value.z,
                e.rotation.value,
                e.velocity.value.x, e.velocity.value.y, e.velocity.value.z,
            })

            recorder.lastDataTime = time
        end

        if not e:has("alive") then
            e:remove("replayRecorder")
            local replayString = bitser.dumps(recorder.data)
            love.filesystem.remove('replay')
            love.filesystem.write('replay', replayString)
            print("Replay saved: ", tostring(#recorder.data))
        end
    end
end

return ReplayRecording