local Concord = require("lib.concord")
local bitser = require("lib.bitser")

local ReplayPlayback = Concord.system({
    pool = {"replayPlayer", "position", "rotation", "velocity"}
})

function ReplayPlayback:update(deltaTime)
    for _, e in ipairs(self.pool) do
        local replay = e.replayPlayer
        if not replay.time then
            replay.time = 0

            local replayString = love.filesystem.read('replay')
            if not replayString then
                e:remove("replayPlayer")
                return
            end

            replay.data = bitser.loads(replayString)
            replay.dataIndex = 0
        end

        if not replay.data[replay.dataIndex + 1] then
            e:remove("replayPlayer")
            e.velocity.value.x = 0
            e.velocity.value.y = 0
            e.velocity.value.z = 0

            return
        end

        while replay.data[replay.dataIndex + 1] and replay.time > replay.data[replay.dataIndex + 1][1] do
            replay.dataIndex = replay.dataIndex + 1

            local state = replay.data[replay.dataIndex]
            e.position.value.x = state[2]
            e.position.value.y = state[3]
            e.position.value.z = state[4]
            e.rotation.value = state[5]
            e.velocity.value.x = state[6]
            e.velocity.value.y = state[7]
            e.velocity.value.z = state[8]
        end

        replay.time = replay.time + deltaTime
    end
end

return ReplayPlayback