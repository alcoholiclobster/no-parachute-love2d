return {
    name = "Level 3",

    fallSpeed = 32,
    fogColor = {15, 0, 0},
    playerRotationMode = "constant",
    playerRotationSpeed = -2.5,

    sidePlanesCount = 60,
    sidePlanes = {
        {
            textures = {
                "level2/wall4",
            }
        },
        {
            textures = {
                "level3/decorative1",
                "level3/decorative2",
                "level3/decorative3",
            }
        }
    },

    planeTypes = {
        -- Big Fan
        big_fan = {
            planes = {
                { texture = "level3/obstacle1_1", rotationSpeed = 4, },
                { texture = "level3/obstacle1_2", position = {0, 0, -1}, },
                { texture = "level3/obstacle1_3", position = {0, 0, 2}, },
            },
            appearFrom = 29,
            appearTo = 40,
        },

        -- Big Fan (Slow)
        big_fan_slow = {
            planes = {
                { texture = "level3/obstacle1_1", rotationSpeed = 0.5, },
                { texture = "level3/obstacle1_2", position = {0, 0, -1}, },
                { texture = "level3/obstacle1_3", position = {0, 0, 2}, },
            },
            appearFrom = 29,
            appearTo = 35,
        },

        -- Big Fan (Reversed)
        big_fan_reversed = {
            planes = {
                { texture = "level3/obstacle1_1", rotationSpeed = -5, },
                { texture = "level3/obstacle1_2", position = {0, 0, -1}, },
                { texture = "level3/obstacle1_3", position = {0, 0, 2}, },
            },
            appearFrom = 41,
            appearTo = 50,
        },

        -- Big Fan (Stopped)
        big_fan_stopped = {
            planes = {
                { texture = "level3/obstacle1_1", rotation = 30, },
                { texture = "level3/obstacle1_2", position = {0, 0, -1}, },
                { texture = "level3/obstacle1_3", position = {0, 0, 2}, },
            },
            appearFrom = 10,
            appearTo = 15,
        },

        -- Box with fan (middle)
        middle_box_with_fan = {
            planes = {
                { texture = "level3/obstacle2_1"},
                { texture = "level3/obstacle2_2", position = {0, 0, -0.5}, rotationSpeed = -16, },
                { texture = "level3/obstacle2_3", position = {0, 0, -1}, },
            },
            appearFrom = 15,
            appearTo = 35,
        },

        -- Pipes through middle
        middle_pipes = {
            planes = {
                { texture = "level3/obstacle3_1", position = {0, 0, 0} },
                { texture = "level3/obstacle3_2", position = {0, 0, -10} },
                { texture = "level3/obstacle3_3", position = {0, 0, -9.5} },
            },
            appearFrom = 3,
            appearTo = 10,
        },

        -- Door at the middle
        middle_door = {
            planes = {
                { texture = "level3/obstacle4_1" },
                { texture = "level3/obstacle4_2", position = {0, 0, -0.5}, velocity = {-8, 0, 0}, moveDelay = 2, },
            },
            appearFrom = 1,
            appearTo = 1,
        },

        -- Ventilation boxes crossed through middle
        crossed_vents = {
            planes = {
                { texture = "level3/obstacle5_1" },
                { texture = "level3/obstacle5_2", position = {0, 0, -2} },
            },
            appearFrom = 10,
            appearTo = 35,
        },

        -- Vertical tube-like thing
        tube_thing = {
            planes = {
                { texture = "level3/obstacle6_0", position = {0, 0, 0}},
                { texture = "level3/obstacle6_2", position = {0, 0, -1}},
                { texture = "level3/obstacle6_3", position = {0, 0, -2}},
                { texture = "level3/obstacle6_1", position = {0, 0, -3}},
                { texture = "level3/obstacle6_2", position = {0, 0, -4}},
                { texture = "level3/obstacle6_3", position = {0, 0, -5}},
                { texture = "level3/obstacle6_1", position = {0, 0, -6}},
                { texture = "level3/obstacle6_3", position = {0, 0, -7}},
                { texture = "level3/obstacle6_4", position = {0, 0, -8}},
                { texture = "level3/obstacle6_2", position = {0, 0, -9}},
                { texture = "level3/obstacle6_1", position = {0, 0, -10}},
                { texture = "level3/obstacle6_3", position = {0, 0, -11}},
                { texture = "level3/obstacle6_4", position = {0, 0, -12}},
                { texture = "level3/obstacle6_3", position = {0, 0, -13}},
                { texture = "level3/obstacle6_2", position = {0, 0, -14}},
                { texture = "level3/obstacle6_1", position = {0, 0, -15}},
                { texture = "level3/obstacle6_3", position = {0, 0, -16}},
                { texture = "level3/obstacle6_2", position = {0, 0, -17}},
                { texture = "level3/obstacle6_4", position = {0, 0, -18}},
                { texture = "level3/obstacle6_1", position = {0, 0, -19}},
                { texture = "level3/obstacle6_2", position = {0, 0, -20}},

                { texture = "level3/obstacle6_5", position = {2.96875, -3.125, -2}, rotationSpeed = 10},
                { texture = "level3/obstacle6_6", position = {0, 0, 5}},
            },
            appearFrom = 20,
            appearTo = 35,

            freeSpaceBefore = 0.5,
            freeSpaceAfter = 1,
        },

        -- Pipes through sides
        side_pipes = {
            planes = {
                { texture = "level3/obstacle7_1", position = {-3, 0, 0} },
                { texture = "level3/obstacle7_1", position = {3, 0, -4} },
            },
            appearFrom = 2,
            appearTo = 20,
        },

        -- Diagonal pipe
        diagonal_pipe = {
            planes = {
                { texture = "level3/obstacle7_1", position = {0, 0, 0}, rotation = 45 },
                { texture = "level3/obstacle7_1", position = {0, 10, 0}, rotation = 45 },
                { texture = "level3/obstacle7_1", position = {0, -10, 0}, rotation = 45 },
            },
            appearFrom = 3,
            appearTo = 12,
        },
    },

    planes = {
        { name = "middle_door", distance = 100, rotation = 270, switchSidePlanes = true, },

        -- Shitty pipes part
        -- { name = "side_pipes", distance = 20, rotation = 0, },
        -- { name = "side_pipes", distance = 10, rotation = 90, },
        -- { name = "middle_pipes", distance = 10, rotation = 90, },
        -- { name = "side_pipes", distance = 10, rotation = 90, },
        -- { name = "diagonal_pipe", distance = 10, rotation = 90, },
        -- { name = "side_pipes", distance = 10, rotation = 90, },
        -- { name = "diagonal_pipe", distance = 10, rotation = 0, },
        -- { name = "diagonal_pipe", distance = 10, rotation = 270, },
        -- { name = "side_pipes", distance = 5, rotation = 0, },
        -- { name = "middle_pipes", distance = 10, rotation = 0, },

        { name = "big_fan", distance = 40, rotation = 0, },
        { name = "big_fan", distance = 40, rotation = 0, },
        { name = "big_fan", distance = 40, rotation = 0, },
        { name = "big_fan", distance = 40, rotation = 0, },
    }
}