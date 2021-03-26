return {
    name = "Old Mine 3",
    nextLevel = "stone_cave1",
    music = "mine_theme1",

    fallSpeed = 35,
    fogColor = {0, 0, 0},
    fogDistance = 60,
    playerRotationMode = "sinusoid",
    playerRotationSpeed = 4,
    playerRotationChangeSpeed = 0.001,

    sidePlanesCount = 45,
    sidePlanesRandomBrightness = true,
    sidePlanes = {
        {
            textures = {
                "levels/old_mine/wall4",
            }
        },
    },

    planeTypes = {
        side_wood1 = {
            planes = {{ texture = "levels/old_mine/obstacle1", }},
        },
        side_wood1_green = {
            planes = {{ texture = "levels/old_mine/obstacle1_1", }},
        },
        middle_bridge = {
            planes = {{ texture = "levels/old_mine/obstacle8", }},
        },
        middle_bridge_green = {
            planes = {{ texture = "levels/old_mine/obstacle8_1", }},
        },
        side_wood2 = {
            planes = {{ texture = "levels/old_mine/obstacle2", }},
        },
        side_wood2_green = {
            planes = {{ texture = "levels/old_mine/obstacle2_1", }},
        },
        -- Corner hole thing
        corner_hole = {
            planes = {
                { texture = "levels/old_mine/obstacle7_1", },
                { texture = "levels/old_mine/obstacle7_2", position = {0, 0, 1} },
            },
        },
        corner_hole_green = {
            planes = {
                { texture = "levels/old_mine/obstacle7_3", },
            },
        },
        -- Long middle hole thing
        middle_hole = {
            planes = {{ texture = "levels/old_mine/obstacle3", }},
        },
        middle_hole_green = {
            planes = {{ texture = "levels/old_mine/obstacle3_1", }},
        },

        -- Single minecart
        minecart = {
            planes = {
                { texture = "levels/old_mine/obstacle4_1", position = {0, 0, -2} },
                { texture = "levels/old_mine/obstacle4_2", position = {-15, 0, 0}, velocity = {5, 0, 0} },
                { texture = "levels/old_mine/obstacle4_3", position = {0, 0, 2} },
            },
        },

        -- Conveyor belts
        belts = {
            planes = {
                { texture = "levels/old_mine/obstacle5_1", position = {0, -2.5, 4}, velocity = {-3, 0, 0} },
                { texture = "levels/old_mine/obstacle5_1", position = {10-0.16, -2.5, 4}, velocity = {-3, 0, 0} },

                { texture = "levels/old_mine/obstacle5_2", position = {0, 2.5, 0}, velocity = {1.5, 0, 0} },
                { texture = "levels/old_mine/obstacle5_2", position = {-10+0.16, 2.5, 0}, velocity = {1.5, 0, 0} },

                { texture = "levels/old_mine/obstacle1", position = {0, 0, -3.5}, velocity = {0, 0, 0}, rotation = 90 },
            },
        },
        belt1 = {
            planes = {
                { texture = "levels/old_mine/obstacle5_1", position = {0, 0, 0}, velocity = {1.5, 0, 0} },
                { texture = "levels/old_mine/obstacle5_1", position = {-10+0.16, 0, 0}, velocity = {1.5, 0, 0} },
            },
        },
        belt2 = {
            planes = {
                { texture = "levels/old_mine/obstacle5_2", position = {0, 0, 0}, velocity = {1.5, 0, 0} },
                { texture = "levels/old_mine/obstacle5_2", position = {-10+0.16, 0, 0}, velocity = {1.5, 0, 0} },
            },
        },
        keep_out = {
            planes = {{ texture = "levels/old_mine/keep_out", }},
        },

        breakable1 = {
            planes = {{ texture = "levels/old_mine/obstacle9", breakable = true }},
        },
    },

    planes = {
        { distance = 50, name = "side_wood1", rotation = 0, },
        { distance = 25, name = "side_wood1", rotation = 90 },
        { distance = 5, name = "middle_bridge", rotation = 90 },
        { distance = 25, name = "side_wood1", rotation = 180 },
        { distance = 20, tunnelShape = { direction = {10, 0} } },
        { distance = 1, tunnelShape = { direction = {0, 0}, rotationSpeed = 0.2 } },
        { distance = 1, name = "middle_bridge", rotation = 90 },
        { name = "side_wood1", distance = 25, rotation = 0 },
        { distance = 25, tunnelShape = { direction = {0, 10} } },
        { name = "side_wood1", distance = 40, rotation = 90 },
        { distance = 10, tunnelShape = { direction = {-10, 0} } },
        { name = "side_wood1", distance = 15, rotation = 180 },
        { name = "middle_bridge", distance = 20, rotation = 90 },
        { distance = 15, tunnelShape = { direction = {0, -10} } },

        { distance = 50, tunnelShape = { direction = {0, 0} }, name = "side_wood2" },
        { distance = 30 },
        { name = "belts", distance = 15, rotation = 90 },
        { name = "middle_bridge", distance = 20, rotation = 180 },
        { name = "belts", distance = 20, rotation = 180 },
        { name = "middle_bridge", distance = 20, rotation = 180 },
        { name = "middle_bridge", distance = 20, rotation = 270 },

        { name = "minecart", distance = 20, rotation = 180 },
        { name = "minecart", distance = 20, rotation = 270 },
        { name = "side_wood1", distance = 10, rotation = 0 },
        { name = "middle_bridge", distance = 10, rotation = 0 },
        { name = "minecart", distance = 20, rotation = 90 },
        { name = "middle_hole", distance = 15, rotation = 0 },

        { distance = 20, tunnelShape = { direction = {8, 8}, rotationSpeed = 0.75 } },
        { distance = 40, tunnelShape = { direction = {11, 0} }, name = "side_wood2" },
        { distance = 40, tunnelShape = { direction = {0, 12} }, name = "side_wood1" },
        { distance = 40, tunnelShape = { direction = {0, -12} }, name = "side_wood2" },
        { distance = 40, tunnelShape = { direction = {0, 0}, rotationSpeed = 0 } },

        {name = "middle_hole", distance = 5, rotation = 90 },

        { name = "minecart", distance = 20, rotation = 270 },

        { name = "middle_hole", distance = 20, rotation = 0 },
        { name = "middle_hole", distance = 5, rotation = 90 },

        { name = "minecart", distance = 15, rotation = 180 },
        { name = "corner_hole", distance = 25, rotation = 0 },
        { name = "middle_bridge", distance = 15, rotation = 0 },
        { name = "corner_hole", distance = 20, rotation = 90 },

        { name = "side_wood1", distance = 30, rotation = 0 },

    },
}