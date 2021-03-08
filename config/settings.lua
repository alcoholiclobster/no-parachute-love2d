return {
    -- Sound
    {
        name = "music_volume",
        label = "Music Volume",
        values = { min = 0, max = 1, default = 0.5 },
    },
    {
        name = "effects_volume",
        label = "Effects Volume",
        values = { min = 0, max = 1, default = 0.5 },
    },

    -- Gameplay
    {
        name = "plane_fading",
        label = "Fade Objects In Front Of Camera",
        values = {
            { name = "Disabled", value = false },
            { name = "Enabled", value = true, default = true },
        },
    },
    {
        name = "speed_lines",
        label = "Speed Lines",
        values = {
            { name = "Disabled", value = false },
            { name = "Enabled", value = true, default = true}
        },
    },

    -- Graphics
    {
        name = "world_quality",
        label = "World Quality",
        values = {
            { name = "Low", value = 0.4 },
            { name = "Medium", value = 0.7 },
            { name = "High", value = 1.0, default = true}
        },
    },
    {
        name = "particles_quality",
        label = "Particles Count",
        values = {
            { name = "Disabled", value = 0 },
            { name = "Low", value = 0.25 },
            { name = "Medium", value = 0.625 },
            { name = "High", value = 1.0, default = true}
        },
    },
    {
        name = "motion_blur",
        label = "Motion Blur",
        values = {
            { name = "Disabled", value = false },
            { name = "Enabled", value = true, default = true}
        },
    },
    {
        name = "decals",
        label = "Decals",
        values = {
            { name = "Disabled", value = false },
            { name = "Enabled", value = true, default = true}
        },
    }
}