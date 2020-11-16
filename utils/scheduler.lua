local scheduler = {}

local threads = {}
local threadCounter = 0
local currentThread
local currentThreadIndex
local deltaTime

local curThread

local function tickRoutine(dt)
    deltaTime = dt
    local currentTime = love.timer.getTime()

    for i = #threads, 1, -1 do
        local thread = threads[i]

        if currentTime >= thread.wakeTime then
            currentThread = thread
            currentThreadIndex = i

            local status = coroutine.status(thread.coroutine)

            if status == "dead" then
                table.remove(threads, i)
            else
                local result, err = coroutine.resume(thread.coroutine)

                if not result then
                    error("Error resuming coroutine: " .. debug.traceback(thread.coroutine, err) .. "\n")
                    table.remove(threads, i)
                end
            end
        end
    end
    currentThread = nil
    currentThreadIndex = nil
end

function scheduler.createThread(threadFunction)
    threadCounter = threadCounter + 1
    table.insert(threads, {
        coroutine = coroutine.create(threadFunction),
        wakeTime = 0,
        id = threadCounter
    })
    return threadCounter
end

function scheduler.killThread(id)
    if currentThread and currentThreadIndex == id then
        return
    end
    for i, thread in ipairs(threads) do
        if thread and thread.id == id then
            table.remove(threads, i)
            return true
        end
    end
    return false
end

function scheduler.getDeltaTime()
    return deltaTime
end

function scheduler.wrap(threadFunction)
    return function ()
        scheduler.createThread(threadFunction)
    end
end

function scheduler.wait(time)
    currentThread.wakeTime = (love.timer.getTime() + time) or 0

    coroutine.yield()
end

local inNext

function scheduler.await(promise)
    if not currentThread then
        return
    end

    -- Remove current thread from the pool (avoid resume from the loop)
    if currentThreadIndex then
        table.remove(threads, currentThreadIndex)
    end

    currentThreadIndex = nil
    local resumableThread = curThread

    inNext = true
    local nextResult
    local nextErr
    local resolved

    promise:next(function (result)
        -- was already resolved? then resolve instantly
        if inNext then
            nextResult = result
            resolved = true

            return
        end

        -- Reattach thread
        table.insert(threads, resumableThread)

        curThread = resumableThread
        currentThreadIndex = #threads

        local result, err = coroutine.resume(resumableThread.coroutine, result)

        if err then
            error("Failed to resume thread: " .. debug.traceback(resumableThread.coroutine, err))
        end

        return result
    end, function (err)
        if err then
            -- if already rejected, handle rejection instantly
            if inNext then
                nextErr = err
                resolved = true

                return
            end

            -- resume with error
            local result, coroErr = coroutine.resume(resumableThread.coroutine, nil, err)

            if coroErr then
                error("Await failure: " .. debug.traceback(resumableThread.coroutine, coroErr, 2))
            end
        end
    end)

    inNext = false

    if resolved then
        if nextErr then
            error(nextErr)
        end

        return nextResult
    end

    curThread = nil
    local result, err = coroutine.yield()

    if err then
        error(err)
    end

    return result
end

function scheduler.update(deltaTime)
    tickRoutine(deltaTime)
end

return scheduler