local level_64 = require "config.levels.level_64"
return {
    name = "Vents 2",
    nextLevel = nil,

    fallSpeed = 45,
    fogColor = {15, 0, 0},
    fogDistance = 70,
    playerRotationMode = "constant",
    playerRotationSpeed = -15,

    sidePlanesRandomBrightness = true,
    sidePlanesCount = 60,
    sidePlanes = {
        {
            textures = {
                "levels/vents/decorative1",
                "levels/vents/decorative2",
                "levels/vents/decorative3",
            }
        },
        {
            textures = {
                "levels/vents/dt1",
                "levels/vents/dt2",
                "levels/vents/dt3",
                "levels/vents/dt4",
                "levels/vents/dt5",
                "levels/vents/dt6",
            },
            pattern = { 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 5, 4, 3, 2, 1, 2, 3, 4, 5 },
        },
        {
            textures = {
                "levels/vents/decorative_dark1",
                "levels/vents/decorative_dark2",
            },
            pattern = { 1, 1, 1, 1, 1, 1, 2, 2 },
        },
    },

    planeTypes = {
        middle_door = {
            planes = {
                { texture = "levels/vents/middle_door_frame" },
                { texture = "levels/vents/middle_door", position = {0, 0, -0.5}, velocity = {-8, 0, 0}, moveDelay = 1.5, },
            },
        },

        middle_long_stick = {
            planes = {
                { texture = "levels/vents/long_stick", position = {0, 0, 0}, rotation = 180 },
            }
        },

        side_long_sticks = {
            planes = {
                { texture = "levels/vents/long_stick", position = {-3, 0, 0} },
                { texture = "levels/vents/long_stick", position = {3, 0, 0} },
            }
        },

        middle_sticks_hole = {
            planes = {
                { texture = "levels/vents/long_stick", position = {-3, 0, 0} },
                { texture = "levels/vents/long_stick", position = {3, 0, 0} },
                { texture = "levels/vents/long_stick", position = {-3, 0,  1}, rotation = 90 },
                { texture = "levels/vents/long_stick", position = {3, 0, 1}, rotation = 90 },
            }
        },

        half_hole = {
            planes = {
                { texture = "levels/vents/half_hole", position = {0, 0, 0} },
            },
        },

        corner_hole = {
            planes = {
                { texture = "levels/vents/corner_hole", position = {0, 0, 0} },
            },
        },

        middle_wide_hole = {
            planes = {
                { texture = "levels/vents/middle_wide_hole", position = {0, 0, 0} },
            },
        },

        middle_small_hole = {
            planes = {
                { texture = "levels/vents/middle_small_hole", position = {0, 0, 0} },
            },
        },

        middle_wide_door = {
            planes = {
                { texture = "levels/vents/middle_wide_door_frame" },
                { texture = "levels/vents/middle_wide_door_left", position = {0, 0, -0.5}, velocity = {-4, 0, 0}, moveDelay = 1.2, },
                { texture = "levels/vents/middle_wide_door_right", position = {0, 0, -0.5}, velocity = {4, 0, 0}, moveDelay = 1.2, },
            },
        },

        -- TODO: Use in the end
        middle_wide_door_breakable = {
            planes = {
                { texture = "levels/vents/middle_wide_door_frame" },
                { texture = "levels/vents/middle_wide_door_left", position = {0, 0, -0.5}, moveDelay = 1.2, breakable = true },
                { texture = "levels/vents/middle_wide_door_right", position = {0, 0, -0.5}, },
            },
        },

        fan = {
            planes = {
                { texture = "levels/vents/fan", rotationSpeed = 3, },
                { texture = "levels/vents/fan_holder", position = {0, 0, -0.5} },
            },
        },


        fan_reversed = {
            planes = {
                { texture = "levels/vents/fan", rotationSpeed = -4, },
                { texture = "levels/vents/fan_holder", position = {0, 0, -0.5} },
            },
        }
    },

    planes = {
        { distance = 100, tunnelShape = { direction = {17, 10} }},
        { distance = 30, name = "middle_wide_door", rotation = 90 },
        { distance = 1, tunnelShape = { direction = {-10, 0} }},
        { distance = 30, tunnelShape = { direction = {0, 0} }},
        { name = "side_long_sticks", distance = 1, rotation = 90 },
        { name = "middle_long_stick", distance = 15, rotation = 0 },
        { name = "corner_hole", distance = 5 },
        { distance = 1, tunnelShape = { offset = {4, 4} }},
        { distance = 25, tunnelShape = { direction = {15, 0} }},
        { name = "side_long_sticks", distance = 15, },
        { name = "middle_wide_door", distance = 25, tunnelShape = { direction = {0, 0} }, switchSidePlanes = true, },
        { distance = 100, switchSidePlanes = true, name = "middle_wide_door", rotation = 90, },
        { name = "middle_wide_door", distance = 5000, rotation = 180, },
    }
}