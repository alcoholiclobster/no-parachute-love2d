local level_64 = require "config.levels.level_64"
return {
    name = "Vents",
    nextLevel = "gears",

    fallSpeed = 40,
    fogColor = {15, 0, 0},
    fogDistance = 70,
    playerRotationMode = "constant",
    playerRotationSpeed = -15,

    sidePlanesCount = 60,
    sidePlanes = {
        {
            textures = {
                "levels/vents/decorative1",
                "levels/vents/decorative2",
                "levels/vents/decorative3",
            }
        }
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
        -- Easy intro
        { name = "middle_door", distance = 100, rotation = 90, },
        { name = "side_long_sticks", distance = 30, rotation = 0, },
        { name = "side_long_sticks", distance = 30, rotation = 180, },
        { name = "middle_long_stick", distance = 30, rotation = 0, },
        { name = "side_long_sticks", distance = 30, rotation = 0, },
        { name = "middle_sticks_hole", distance = 30, rotation = 180, },

        -- Corner things
        { name = "middle_wide_hole", distance = 30, rotation = 0, },
        { name = "side_long_sticks", distance = 30, rotation = 90, },
        { name = "half_hole", distance = 10, rotation = 180, },
        { name = "middle_long_stick", distance = 20, rotation = 0, },
        { name = "corner_hole", distance = 5, rotation = 0, },
        { name = "middle_long_stick", distance = 30, rotation = 180, },
        { name = "half_hole", distance = 5, rotation = 180, },
        { name = "corner_hole", distance = 25, rotation = 180, },
        { name = "middle_long_stick", distance = 15, rotation = 180, },
        { name = "corner_hole", distance = 15, rotation = 90, },
        { name = "middle_long_stick", distance = 15, rotation = 0, },
        { name = "corner_hole", distance = 15, rotation = 180, },

        -- Easy part
        { name = "middle_wide_hole", distance = 30, rotation = 0, },
        { name = "middle_sticks_hole", distance = 20, rotation = 0, },
        { name = "side_long_sticks", distance = 30, rotation = 0, },
        { name = "side_long_sticks", distance = 30, rotation = 0, },
        { name = "middle_long_stick", distance = 30, rotation = 0, },
        { name = "middle_wide_hole", distance = 10, rotation = 0, },
        { name = "middle_wide_door", distance = 40, rotation = 0, },

        { name = "half_hole", distance = 40, rotation = 0, },
        { name = "half_hole", distance = 15, rotation = 0, },
        { name = "half_hole", distance = 15, rotation = 0, },
        { name = "half_hole", distance = 25, rotation = 180, },
        { name = "half_hole", distance = 15, rotation = 180, },
        { name = "half_hole", distance = 15, rotation = 180, },
        { name = "half_hole", distance = 15, rotation = 90, },
        { name = "half_hole", distance = 15, rotation = 0, },
        { name = "half_hole", distance = 15, rotation = 270, },
        { name = "corner_hole", distance = 15, rotation = 180, },
        { name = "half_hole", distance = 15, rotation = 180, },
        { name = "corner_hole", distance = 15, rotation = 90, },
        { name = "half_hole", distance = 15, rotation = 90, },
        { name = "corner_hole", distance = 15, rotation = 0, },
        { name = "half_hole", distance = 15, rotation = 0, },
        { name = "middle_sticks_hole", distance = 30, rotation = 0, },

        -- Ez part
        { name = "middle_wide_hole", distance = 20, rotation = 0, },
        { name = "middle_wide_door", distance = 10, rotation = 0, },
        { name = "middle_wide_door", distance = 20, rotation = 180, },
        { name = "middle_wide_door", distance = 20, rotation = 0, },
        { name = "middle_wide_door", distance = 20, rotation = 180, },
        { name = "middle_wide_door", distance = 20, rotation = 0, },
        { name = "middle_wide_door", distance = 20, rotation = 180, },
        { name = "middle_wide_hole", distance = 10, rotation = 0, },

        -- Fans
        { name = "fan", distance = 40, rotation = 0, },
        { name = "middle_wide_hole", distance = 30, rotation = 90, },
        { name = "fan", distance = 20, rotation = 0, },
        { name = "middle_wide_hole", distance = 20, rotation = 90, },
        { name = "middle_small_hole", distance = 15, rotation = 90, },
        { name = "middle_wide_hole", distance = 15, rotation = 90, },
        { name = "fan", distance = 25, rotation = 0, },
        { name = "middle_wide_hole", distance = 30, rotation = 0, },
        { name = "middle_small_hole", distance = 15, rotation = 0, },
        { name = "middle_small_hole", distance = 15, rotation = 0, },
        { name = "middle_wide_hole", distance = 15, rotation = 0, },
        { name = "fan_reversed", distance = 45, rotation = 0, },
        { name = "middle_wide_hole", distance = 25, rotation = 0, },
        { name = "middle_small_hole", distance = 15, rotation = 0, },
        { name = "middle_small_hole", distance = 40, rotation = 0, },
        { name = "middle_small_hole", distance = 8, rotation = 0, },
        { name = "middle_small_hole", distance = 8, rotation = 0, },
        { name = "middle_small_hole", distance = 8, rotation = 0, },
        { name = "middle_small_hole", distance = 8, rotation = 0, },

        -- Ez part
        { name = "side_long_sticks", distance = 15, rotation = 0, },
        { name = "middle_small_hole", distance = 15, rotation = 0, },
        { name = "middle_small_hole", distance = 8, rotation = 0, },
        { name = "middle_small_hole", distance = 8, rotation = 0, },
        { name = "middle_small_hole", distance = 8, rotation = 0, },
        { name = "middle_small_hole", distance = 8, rotation = 0, },

        -- Half hole fans
        { name = "half_hole", distance = 40, rotation = 0, },
        { name = "half_hole", distance = 25, rotation = 180, },

        { name = "half_hole", distance = 35, rotation = 180, },
        { name = "fan", distance = 1, rotation = 0, },

        { name = "half_hole", distance = 35, rotation = 0, },
        { name = "fan", distance = 1, rotation = 180, },
        { name = "side_long_sticks", distance = 20, rotation = 180, },
        { name = "side_long_sticks", distance = 30, rotation = 180, },
        { name = "middle_long_stick", distance = 30, rotation = 180, },
        { name = "fan", distance = 1, rotation = 180, },
        { name = "side_long_sticks", distance = 20, rotation = 0, },
        { name = "middle_small_hole", distance = 20, rotation = 0, },
        { name = "half_hole", distance = 35, rotation = 90, },
        { name = "fan", distance = 1, rotation = 270, },
        { name = "half_hole", distance = 35, rotation = 90, },
        { name = "fan_reversed", distance = 1, rotation = 270, },

        -- Fake door part
        { name = "middle_wide_door", distance = 50, rotation = 180, },
        { name = "middle_wide_door_breakable", distance = 30, rotation = 180, },
    }
}