return {
    -- Sound
    {
        name = "music_volume",
        values = { min = 0, max = 1, default = 0.5 },
    },
    {
        name = "effects_volume",
        values = { min = 0, max = 1, default = 0.5 },
    },

    -- Gameplay
    {
        name = "plane_fading",
        values = {
            { name = "Disabled", value = false },
            { name = "Enabled", value = true, default = true },
        },
    },
    {
        name = "speed_lines",
        values = {
            { name = "Disabled", value = false },
            { name = "Enabled", value = true, default = true}
        },
    },

    -- Graphics
    {
        name = "world_quality",
        values = {
            { name = "Low", value = 0.4 },
            { name = "Medium", value = 0.7 },
            { name = "High", value = 1.0, default = true}
        },
    },
    {
        name = "particles_quality",
        values = {
            { name = "Disabled", value = 0 },
            { name = "Low", value = 0.25 },
            { name = "Medium", value = 0.625 },
            { name = "High", value = 1.0, default = true}
        },
    },
    {
        name = "motion_blur",
        values = {
            { name = "Disabled", value = false },
            { name = "Enabled", value = true, default = true}
        },
    },
    {
        name = "decals",
        values = {
            { name = "Disabled", value = false },
            { name = "Enabled", value = true, default = true}
        },
    }
}