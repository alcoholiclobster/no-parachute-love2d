local settings = {}

local state = {
    world_quality = 0.4,
    particles_quality = 0.25,
    motion_blur = false,
    decals = false,
}

function settings.get(name)
    return state[name]
end

function settings.set(name, value)
    state[name] = value
end

-- function settings.define(name, values)

-- end

return settings