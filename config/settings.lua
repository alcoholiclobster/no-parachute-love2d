return {
    -- {
    --     name = "difficulty",
    --     values = {
    --         { name = "lbl_settings_difficulty_peaceful", value = "peaceful" },
    --         { name = "lbl_settings_difficulty_easy", value = "easy" },
    --         { name = "lbl_settings_difficulty_normal", value = "normal", default = true },
    --     },
    -- },
    -- Language
    {
        name = "language",
        values = {
            { name = "lbl_settings_lang_english", value = "en"},
            { name = "lbl_settings_lang_russian", value = "ru"},
        }
    },
    -- Sound
    {
        name = "master_volume",
        values = {
            { name = "lbl_settings_disabled", value = 0 },
            { name = "lbl_settings_enabled", value = 1, default = true },
        },
    },
    {
        name = "music_volume",
        values = {
            { name = "lbl_settings_disabled", value = 0 },
            { name = "lbl_settings_enabled", value = 1, default = true },
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
    -- {
    --     name = "character_transparency",
    --     values = {
    --         { name = "lbl_settings_disabled", value = false, default = true },
    --         { name = "lbl_settings_enabled", value = true }
    --     },
    -- },
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
            { name = "lbl_settings_low", value = 0.5 },
            { name = "lbl_settings_medium", value = 0.75 },
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
        name = "blood",
        values = {
            { name = "lbl_settings_disabled", value = false },
            { name = "lbl_settings_enabled", value = true, default = true}
        },
    }
}