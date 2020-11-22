return {
    name = "Vents",
    nextLevel = "level3_2",

    fallSpeed = 32,
    fogColor = {15, 0, 0},
    fogDistance = 70,
    playerRotationMode = "constant",
    playerRotationSpeed = -2.5,

    sidePlanesCount = 60,
    sidePlanes = {
        {
            textures = {
                "levels/level3_1/decorative1",
                "levels/level3_1/decorative2",
                "levels/level3_1/decorative3",
            }
        }
    },

    planeTypes = {
        -- Big Fan
        big_fan = {
            planes = {
                { texture = "levels/level3_1/obstacle1_1", rotationSpeed = 4, },
                { texture = "levels/level3_1/obstacle1_2", position = {0, 0, -1}, },
                { texture = "levels/level3_1/obstacle1_3", position = {0, 0, 2}, },
            },
        },

        -- Big Fan (Slow)
        big_fan_slow = {
            planes = {
                { texture = "levels/level3_1/obstacle1_1", rotationSpeed = 0.5, },
                { texture = "levels/level3_1/obstacle1_2", position = {0, 0, -1}, },
                { texture = "levels/level3_1/obstacle1_3", position = {0, 0, 2}, },
            },
        },

        -- Big Fan (Reversed)
        big_fan_reversed = {
            planes = {
                { texture = "levels/level3_1/obstacle1_1", rotationSpeed = -5, },
                { texture = "levels/level3_1/obstacle1_2", position = {0, 0, -1}, },
                { texture = "levels/level3_1/obstacle1_3", position = {0, 0, 2}, },
            },
        },

        -- Big Fan (Stopped)
        big_fan_stopped = {
            planes = {
                { texture = "levels/level3_1/obstacle1_1", rotation = 30, },
                { texture = "levels/level3_1/obstacle1_2", position = {0, 0, -1}, },
                { texture = "levels/level3_1/obstacle1_3", position = {0, 0, 2}, },
            },
        },

        -- Box with fan (middle)
        middle_box_with_fan = {
            planes = {
                { texture = "levels/level3_1/obstacle2_1"},
                { texture = "levels/level3_1/obstacle2_2", position = {0, 0, -0.5}, rotationSpeed = -16, },
                { texture = "levels/level3_1/obstacle2_3", position = {0, 0, -1}, },
            },
        },

        -- Pipes through middle
        middle_pipes = {
            planes = {
                { texture = "levels/level3_1/obstacle3_1", position = {0, 0, 0} },
                { texture = "levels/level3_1/obstacle3_2", position = {0, 0, -10} },
                { texture = "levels/level3_1/obstacle3_3", position = {0, 0, -9.5} },
            },
        },

        -- Door at the middle
        middle_door = {
            planes = {
                { texture = "levels/level3_1/obstacle4_1" },
                { texture = "levels/level3_1/obstacle4_2", position = {0, 0, -0.5}, velocity = {-8, 0, 0}, moveDelay = 2, },
            },
        },

        middle_door_clean = {
            planes = {
                { texture = "levels/level3_1/obstacle8" },
                { texture = "levels/level3_1/obstacle4_2", position = {0, 0, -0.5}, velocity = {-8, 0, 0}, moveDelay = 2, },
            },
        },

        -- Ventilation boxes crossed through middle
        crossed_vents = {
            planes = {
                { texture = "levels/level3_1/obstacle5_1" },
                { texture = "levels/level3_1/obstacle5_2", position = {0, 0, -2} },
            },
        },

        -- Vertical tube-like thing
        tube_thing = {
            planes = {
                { texture = "levels/level3_1/obstacle6_0", position = {0, 0, 0}},
                { texture = "levels/level3_1/obstacle6_1", position = {0, 0, -2}},

                { texture = "levels/level3_1/obstacle6_5", position = {2.96875, -3.125, -2}, rotationSpeed = 10},
                { texture = "levels/level3_1/obstacle6_6", position = {0, 0, 5}},
            },
        },

        side_pipes = {
            planes = {
                { texture = "levels/level3_1/obstacle7_1", position = {-3, 0, 0} },
                { texture = "levels/level3_1/obstacle7_1", position = {3, 0, -4} },
            },
        },

        diagonal_pipe = {
            planes = {
                { texture = "levels/level3_1/obstacle7_1", position = {0, 0, 0}, rotation = 45 },
                { texture = "levels/level3_1/obstacle7_1", position = {0, 10, 0}, rotation = 45 },
                { texture = "levels/level3_1/obstacle7_1", position = {0, -10, 0}, rotation = 45 },
            },
        },

        middle_hole = {
            planes = {
                { texture = "levels/level3_1/obstacle8" },
            },
        },
    },

    planes = {
        { name = "middle_door", distance = 100, rotation = 0 },

        { name = "crossed_vents", distance = 50, rotation = 0 },
        { name = "middle_hole", distance = 10, rotation = 0 },
        { name = "diagonal_pipe", distance = 40, rotation = 0 },
        { name = "diagonal_pipe", distance = 10, rotation = 90 },
        { name = "middle_hole", distance = 25, rotation = 0 },
        { name = "crossed_vents", distance = 10, rotation = 270 },
        { name = "middle_hole", distance = 17, rotation = 270 },
        { name = "middle_door_clean", distance = 30, rotation = 0 },

        { name = "diagonal_pipe", distance = 25, rotation = 0 },
        { name = "middle_pipes", distance = 20, rotation = 0 },
        { name = "diagonal_pipe", distance = 20, rotation = 90 },
        { name = "side_pipes", distance = 10, rotation = 90 },
        { name = "middle_hole", distance = 15, rotation = 270 },
        { name = "middle_pipes", distance = 20, rotation = 90 },
        { name = "side_pipes", distance = 30, rotation = 90 },
        { name = "side_pipes", distance = 10, rotation = 180 },
        { name = "crossed_vents", distance = 10, rotation = 270 },
        { name = "middle_door_clean", distance = 20, rotation = 270 },

        { name = "big_fan_stopped", distance = 30, rotation = 0 },
        { name = "big_fan_stopped", distance = 30, rotation = 90 },
        { name = "big_fan_slow", distance = 30, rotation = 180 },
        { name = "middle_hole", distance = 15, rotation = 0 },
        { name = "middle_box_with_fan", distance = 15, rotation = 0 },
        { name = "big_fan_slow", distance = 15, rotation = 90 },

        { name = "middle_door_clean", distance = 40, rotation = 0 },
        { name = "middle_door_clean", distance = 20, rotation = 0 },
        { name = "middle_door_clean", distance = 20, rotation = 0 },
        { name = "middle_door_clean", distance = 20, rotation = 0 },
        { name = "middle_box_with_fan", distance = 20, rotation = 0 },
        { name = "side_pipes", distance = 10, rotation = 0 },
        { name = "middle_box_with_fan", distance = 10, rotation = 90 },
        { name = "side_pipes", distance = 10, rotation = 0 },
        { name = "side_pipes", distance = 5, rotation = 90 },
        { name = "crossed_vents", distance = 15, rotation = 0 },
        { name = "diagonal_pipe", distance = 30, rotation = 0 },
        { name = "tube_thing", distance = 20, rotation = 0 },
        { name = "middle_hole", distance = 35, rotation = 0 },
        { name = "side_pipes", distance = 5, rotation = 90 },
        { name = "tube_thing", distance = 10, rotation = 180 },
        { name = "tube_thing", distance = 21, rotation = 180 },
        { name = "tube_thing", distance = 21, rotation = 180 },
        { name = "diagonal_pipe", distance = 30, rotation = 0 },
        { name = "middle_hole", distance = 10, rotation = 0 },
        { name = "middle_hole", distance = 1, rotation = 0 },
        { name = "middle_hole", distance = 2, rotation = 90 },
        { name = "middle_hole", distance = 1, rotation = 180 },
        { name = "middle_hole", distance = 1, rotation = 270 },
        { name = "middle_hole", distance = 2, rotation = 90 },
        { name = "middle_hole", distance = 1, rotation = 180 },
        { name = "middle_hole", distance = 2, rotation = 0 },
        { name = "middle_hole", distance = 1, rotation = 90 },
        { name = "middle_hole", distance = 2, rotation = 270 },
        { name = "diagonal_pipe", distance = 35, rotation = 0 },
        { name = "tube_thing", distance = 10, rotation = 0 },
        { name = "diagonal_pipe", distance = 35, rotation = 0 },
        { name = "tube_thing", distance = 15, rotation = 180 },
        { name = "diagonal_pipe", distance = 35, rotation = 0 },
        { name = "side_pipes", distance = 5, rotation = 90 },
        { name = "side_pipes", distance = 10, rotation = 0 },

        { name = "middle_door_clean", distance = 35, rotation = 0 },
        { name = "side_pipes", distance = 30, rotation = 90 },
        { name = "side_pipes", distance = 10, rotation = 180 },
        { name = "side_pipes", distance = 30, rotation = 90 },
        { name = "side_pipes", distance = 30, rotation = 90 },
        { name = "side_pipes", distance = 30, rotation = 90 },
        { name = "side_pipes", distance = 40, rotation = 180 },
        { name = "side_pipes", distance = 20, rotation = 90 },
        { name = "big_fan", distance = 60, rotation = 90 },
        { name = "big_fan_reversed", distance = 40, rotation = 90 },
        { name = "big_fan", distance = 40, rotation = 0 },
        { name = "big_fan_reversed", distance = 40, rotation = 0 },
        { name = "big_fan", distance = 40, rotation = 90 },

    }
}