return {
    name = "Vents 1",
    nextLevel = "vents2",
    music = "vents_theme",

    fallSpeed = 40,
    fogColor = {15, 0, 0},
    fogDistance = 70,
    playerRotationMode = "constant",
    playerRotationSpeed = -12,

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
                { texture = "levels/vents/fan_holder", position = {-0.5, 0, 2}},
                { texture = "levels/vents/corner_hole" },
                { texture = "levels/vents/small_fan", position = {-2.96875, -3.125, -0.5}, rotationSpeed = -16, },
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
        { name = "fan", distance = 30, },
        { name = "side_long_sticks", distance = 30, rotation = 0, },
        { name = "middle_sticks_hole", distance = 30, rotation = 180, },

        -- Corner things
        { name = "middle_wide_hole", distance = 30, rotation = 0, },
        { name = "side_long_sticks", distance = 30, rotation = 90, },
        { name = "half_hole", distance = 10, rotation = 180, },
        { name = "middle_long_stick", distance = 23, rotation = 0, },
        { name = "corner_hole", distance = 5, rotation = 0, },
        { name = "middle_long_stick", distance = 32, rotation = 180, },
        { name = "half_hole", distance = 5, rotation = 180, },
        { name = "corner_hole", distance = 25, rotation = 180, },
        { name = "middle_long_stick", distance = 17, rotation = 180, },
        { name = "corner_hole", distance = 15, rotation = 90, },
        { name = "middle_long_stick", distance = 16, rotation = 0, },
        { name = "corner_hole", distance = 15, rotation = 180, },

        -- Ez part
        { name = "side_long_sticks", distance = 15, rotation = 0, },
        { name = "middle_small_hole", distance = 15, rotation = 0, },
        { name = "middle_small_hole", distance = 8, rotation = 0, },
        { name = "middle_small_hole", distance = 8, rotation = 0, },
        { name = "middle_small_hole", distance = 8, rotation = 0, },
        { name = "middle_small_hole", distance = 8, rotation = 0, },

        { name = "fan", distance = 30, },
        { name = "fan", distance = 30, },

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
        { name = "fan", distance = 40, },
    }
}