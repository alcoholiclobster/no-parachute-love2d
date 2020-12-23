local level_64 = require "config.levels.level_64"
return {
    name = "Vents 2",
    nextLevel = "lava",

    fallSpeed = 45,
    fogColor = {15, 0, 0},
    fogDistance = 70,
    playerRotationMode = "constant",
    playerRotationSpeed = -12,

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

        half_hole_transparent = {
            planes = {
                { texture = "levels/vents/half_hole_transparent", position = {0, 0, 0} },
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
                { texture = "levels/vents/fan", rotationSpeed = 4, },
                { texture = "levels/vents/fan_holder", position = {0, 0, -0.5} },
            },
        },


        fan2 = {
            planes = {
                { texture = "levels/vents/fan", rotationSpeed = 5, },
                { texture = "levels/vents/fan_holder", position = {0, 0, -0.5} },
            },
        },

        fan3 = {
            planes = {
                { texture = "levels/vents/fan", rotationSpeed = 6, },
                { texture = "levels/vents/fan_holder", position = {0, 0, -0.5} },
            },
        },

        fan_part1 = {
            planes = {
                { texture = "levels/vents/fan", rotationSpeed = 6, },
                { texture = "levels/vents/fan_holder", position = {0, 0, -0.5} },
            },
        },

        fan_part2 = {
            planes = {
                { texture = "levels/vents/fan", rotationSpeed = 6, },
            },
        },

        fan_reversed = {
            planes = {
                { texture = "levels/vents/fan", rotationSpeed = -4, },
                { texture = "levels/vents/fan_holder", position = {0, 0, -0.5} },
            },
        },

        fan_slow = {
            planes = {
                { texture = "levels/vents/fan", rotationSpeed = 1, },
                { texture = "levels/vents/fan_holder", position = {0, 0, -0.5} },
            },
        },

        -- fan_rotated1 = {
        --     planes = {
        --         { texture = "levels/vents/fan", rotationSpeed = 4, rotation = 0 },
        --         { texture = "levels/vents/fan", rotationSpeed = 4, rotation = 10, position = {0, 0, -2} },
        --         { texture = "levels/vents/fan", rotationSpeed = 4, rotation = 20, position = {0, 0, -4} },
        --         { texture = "levels/vents/fan", rotationSpeed = 4, rotation = 30, position = {0, 0, -6} },
        --         { texture = "levels/vents/fan", rotationSpeed = 4, rotation = 40, position = {0, 0, -8} },
        --         { texture = "levels/vents/fan", rotationSpeed = 4, rotation = 50, position = {0, 0, -10} },
        --         { texture = "levels/vents/fan", rotationSpeed = 4, rotation = 60, position = {0, 0, -12} },
        --         { texture = "levels/vents/fan_holder", position = {0, 0, -0.5} },
        --     },
        -- },

        -- fan_rotated1_reversed = {
        --     planes = {
        --         { texture = "levels/vents/fan", rotationSpeed = -4, rotation = 0 },
        --         { texture = "levels/vents/fan", rotationSpeed = -4, rotation = 30, position = {0, 0, -2} },
        --         { texture = "levels/vents/fan", rotationSpeed = -4, rotation = 60, position = {0, 0, -4} },
        --         { texture = "levels/vents/fan_holder", position = {0, 0, -0.5} },
        --     },
        -- },
    },

    planes = {
        -- Curved tunnel
        { distance = 100, tunnelShape = { direction = {17, 10} }},
        { distance = 30, name = "middle_wide_door", rotation = 90 },
        { distance = 1, tunnelShape = { direction = {-10, 0} }},
        { distance = 30, tunnelShape = { direction = {0, 0} }},
        { name = "middle_long_stick", distance = 15, rotation = 0 },
        { name = "corner_hole", distance = 5 },
        { distance = 1, tunnelShape = { offset = {4, 4} }},
        { distance = 25, tunnelShape = { direction = {15, 0} }},
        { name = "middle_wide_door", distance = 40, tunnelShape = { direction = {0, 0} }, switchSidePlanes = true, },
        { distance = 40, name = "half_hole_transparent", rotation = 0, },
        { distance = 40, name = "half_hole_transparent", rotation = 180, },
        { distance = 20, switchSidePlanes = true, name = "middle_wide_door", rotation = 90, },

        -- { distance = 100, },
        -- Hard corner thing
        { distance = 50, name = "corner_hole", rotation = 0, },
        { distance = 35, name = "corner_hole", rotation = 180, },
        { distance = 35, name = "corner_hole", rotation = 0, },
        { distance = 19, name = "middle_long_stick", rotation = 90, },
        { distance = 20, name = "corner_hole", rotation = 180, },
        { distance = 38, name = "corner_hole", rotation = 0, },
        { distance = 18, name = "middle_small_hole", },
        { distance = 17, name = "corner_hole", rotation = 180, },
        { distance = 36, name = "corner_hole", rotation = 0, },

        -- Fans
        { distance = 36, name = "fan", rotation = 0, },
        { distance = 20, name = "middle_wide_hole", rotation = 0, },
        { distance = 20, name = "fan2", rotation = 90, },
        { distance = 60, },
        { distance = 30, name = "middle_wide_door", rotation = 0, },
        { distance = 7, name = "middle_wide_door", rotation = 90, },
        { distance = 7, name = "middle_wide_door", rotation = 180, },

        { distance = 20, tunnelShape = { direction = {15, 0} }},
        { distance = 20, name = "middle_long_stick", position = {2.5, 0, 0}},
        { distance = 20, tunnelShape = { direction = {-15, 0} }},
        { distance = 1, name = "middle_long_stick", position = {2.5, 0, 0}, rotation = 90},
        { distance = 25, name = "middle_long_stick", position = {-2.5, 0, 0}, rotation = 90},
        { distance = 15, tunnelShape = { direction = {15, 0} }},
        { distance = 25, name = "middle_long_stick", position = {-2.5, 0, 0}, rotation = 0},
        { distance = 10, name = "middle_long_stick", position = {2.5, 0, 0}, rotation = 90},
        { distance = 5, tunnelShape = { direction = {0, 0} }},
        { distance = 20, name = "middle_wide_door" },
        { distance = 40, name = "fan_slow" },
        { distance = 30, name = "middle_wide_door" },
        { distance = 40, name = "fan_part1" },
        { distance = 4, name = "fan_part2" },
        { distance = 4, name = "fan_part2" },
        { distance = 4, name = "fan_part2" },
        { distance = 4, name = "fan_part2" },
        { distance = 4, name = "fan_part2" },
        { distance = 4, name = "fan_part2" },
        { distance = 4, name = "fan_part2" },
        { distance = 4, name = "fan_part2" },
        { distance = 4, name = "fan_part2" },
        { distance = 4, name = "fan_part2" },
        { distance = 4, name = "fan_part2" },
        { distance = 4, name = "fan_part2" },
        { distance = 4, name = "fan_part2" },
        { distance = 4, name = "fan_part2" },
        { distance = 4, name = "fan_part2" },
        { distance = 4, name = "fan_part2" },
        { distance = 4, name = "fan_part2" },
        { distance = 4, name = "fan_part2" },
        { distance = 4, name = "fan_part2" },
        { distance = 4, name = "fan_part2" },
        { distance = 4, name = "fan_part2" },
        { distance = 20, name = "middle_small_hole" },

        -- { distance = 500},
        -- -- Weird shaped thing (good for ending)
        -- { distance = 20, tunnelShape = { offset = {1, 0} }},
        -- { distance = 0.1, tunnelShape = { offset = {1, 0} }},
        -- { distance = 0.1, tunnelShape = { offset = {1, 0} }},
        -- { distance = 10, tunnelShape = { offset = {-4, 0} }},

        -- { distance = 20, tunnelShape = { offset = {0, 1} }},
        -- { distance = 0.1, tunnelShape = { offset = {0, 1} }},
        -- { distance = 0.1, tunnelShape = { offset = {0, 1} }},
        -- { distance = 10, tunnelShape = { offset = {0, -4} }},
    }
}