return {
    -- Gameplay
    {
        name = "plane_fading",
        readableName = "Fade Objects In Front Of Camera",
        values = {
            { name = "Disabled", value = false },
            { name = "Enabled", value = true, default = true },
        },
    },
    {
        name = "speed_lines",
        readableName = "Speed Lines",
        values = {
            { name = "Disabled", value = false },
            { name = "Enabled", value = true, default = true}
        },
    },

    -- Graphics
    {
        name = "world_quality",
        readableName = "World Quality",
        values = {
            { name = "Low", value = 0.4 },
            { name = "Medium", value = 0.7 },
            { name = "High", value = 1.0, default = true}
        },
    },
    {
        name = "particles_quality",
        readableName = "Particles Count",
        values = {
            { name = "Disabled", value = 0 },
            { name = "Low", value = 0.25 },
            { name = "Medium", value = 0.625 },
            { name = "High", value = 1.0, default = true}
        },
    },
    {
        name = "motion_blur",
        readableName = "Motion Blur",
        values = {
            { name = "Disabled", value = false },
            { name = "Enabled", value = true, default = true}
        },
    },
    {
        name = "decals",
        readableName = "Decals",
        values = {
            { name = "Disabled", value = false },
            { name = "Enabled", value = true, default = true}
        },
    }
}