return {
    -- Language
    {
        name = "language",
        values = {
            { name = "lbl_settings_lang_english", value = "en", default = true},
            { name = "lbl_settings_lang_russian", value = "ru", default = true},
        }
    },
    -- Sound
    {
        name = "master_volume",
        values = {
            { name = "1", value = 0 },
            { name = "2", value = 0.2 },
            { name = "3", value = 0.3 },
            { name = "4", value = 0.4 },
            { name = "5", value = 0.5 },
            { name = "6", value = 0.6 },
            { name = "7", value = 0.7 },
            { name = "8", value = 0.8 },
            { name = "9", value = 0.9 },
            { name = "10", value = 1, default = true },
        },
    },
    {
        name = "music_volume",
        values = {
            { name = "1", value = 0 },
            { name = "2", value = 0.2 },
            { name = "3", value = 0.3 },
            { name = "4", value = 0.4 },
            { name = "5", value = 0.5 },
            { name = "6", value = 0.6 },
            { name = "7", value = 0.7 },
            { name = "8", value = 0.8 },
            { name = "9", value = 0.9 },
            { name = "10", value = 1, default = true },
        },
    },

    -- Gameplay
    {
        name = "plane_fading",
        values = {
            { name = "lbl_settings_disabled", value = false },
            { name = "lbl_settings_enabled", value = true, default = true },
        },
    },
    {
        name = "speed_lines",
        values = {
            { name = "lbl_settings_disabled", value = false },
            { name = "lbl_settings_enabled", value = true, default = true}
        },
    },

    -- Graphics
    {
        name = "world_quality",
        values = {
            { name = "lbl_settings_low", value = 0.4 },
            { name = "lbl_settings_medium", value = 0.7 },
            { name = "lbl_settings_high", value = 1.0, default = true}
        },
    },
    {
        name = "particles_quality",
        values = {
            { name = "lbl_settings_disabled", value = 0 },
            { name = "lbl_settings_low", value = 0.25 },
            { name = "lbl_settings_medium", value = 0.625 },
            { name = "lbl_settings_high", value = 1.0, default = true}
        },
    },
    {
        name = "motion_blur",
        values = {
            { name = "lbl_settings_disabled", value = false },
            { name = "lbl_settings_enabled", value = true, default = true}
        },
    },
    {
        name = "decals",
        values = {
            { name = "lbl_settings_disabled", value = false },
            { name = "lbl_settings_enabled", value = true, default = true}
        },
    }
}