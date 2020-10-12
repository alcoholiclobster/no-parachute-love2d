return {
    name = "Level 2",

    fallSpeed = 30,
    fogColor = {0, 0, 0},
    playerRotationMode = "sinusoid",
    playerRotationSpeed = 0.7,
    playerRotationChangeSpeed = 0.3,
    playerRotationSpeedDependsOnProgress = true,

    sidePlanesCount = 50,
    sidePlanes = {
        { texture = "level2/wall1" },
    },

    planeTypes = {
        side_wood1 = {
            planes = {{ texture = "level2/obstacle1", }},
        },
        middle_bridge = {
            planes = {{ texture = "level2/obstacle8", }},
        },
        side_wood2 = {
            planes = {{ texture = "level2/obstacle2", }},
        },
        side_wood2_2 = {
            planes = {{ texture = "level2/obstacle2_1", }},
        },
        -- Corner hole thing
        corner_hole = {
            planes = {
                { texture = "level2/obstacle7_1", },
                { texture = "level2/obstacle7_2", position = {0, 0, 1} },
            },
        },
        corner_hole2 = {
            planes = {
                { texture = "level2/obstacle7_3", },
            },
        },
        -- Long middle hole thing
        middle_hole = {
            planes = {{ texture = "level2/obstacle3", }},
        },

        -- Single minecart
        minecart = {
            planes = {
                { texture = "level2/obstacle4_1", position = {0, 0, -2} },
                { texture = "level2/obstacle4_2", position = {-15, 0, 0}, velocity = {5, 0, 0} },
                { texture = "level2/obstacle4_3", position = {0, 0, 2} },
            },
        },

        -- Conveyor belts
        belts = {
            planes = {
                { texture = "level2/obstacle5_1", position = {0, -2.5, 4}, velocity = {-3, 0, 0} },
                { texture = "level2/obstacle5_1", position = {10-0.16, -2.5, 4}, velocity = {-3, 0, 0} },

                { texture = "level2/obstacle5_2", position = {0, 2.5, 0}, velocity = {1.5, 0, 0} },
                { texture = "level2/obstacle5_2", position = {-10+0.16, 2.5, 0}, velocity = {1.5, 0, 0} },

                { texture = "level2/obstacle1", position = {0, 0, -3.5}, velocity = {0, 0, 0}, rotation = 90 },
            },
        },
        belt1 = {
            planes = {
                { texture = "level2/obstacle5_1", position = {0, 0, 0}, velocity = {1.5, 0, 0} },
                { texture = "level2/obstacle5_1", position = {-10+0.16, 0, 0}, velocity = {1.5, 0, 0} },
            },
        },
        belt2 = {
            planes = {
                { texture = "level2/obstacle5_2", position = {0, 0, 0}, velocity = {1.5, 0, 0} },
                { texture = "level2/obstacle5_2", position = {-10+0.16, 0, 0}, velocity = {1.5, 0, 0} },
            },
        }
    },

    planes = {
        { name = "side_wood1", distance = 50, rotation = 0 },
        { name = "side_wood1", distance = 25, rotation = 180 },
        { name = "side_wood1", distance = 25, rotation = 90 },
        { name = "side_wood1", distance = 25, rotation = 270 },

        -- 3 seconds

        { name = "middle_bridge", distance = 20, rotation = 0 },
        { name = "side_wood1", distance = 20, rotation = 0 },
        { name = "middle_bridge", distance = 20, rotation = 90 },
        { name = "side_wood2_2", distance = 20, rotation = 0 },

        --

        { name = "side_wood1", distance = 20, rotation = 90 },
        { name = "corner_hole2", distance = 20, rotation = 0 },
        { name = "side_wood1", distance = 20, rotation = 180 },
        { name = "corner_hole", distance = 15, rotation = 180 },

        --

        { name = "middle_hole", distance = 20, rotation = 0 },
        { name = "side_wood2_2", distance = 10, rotation = 0 },
        { name = "middle_hole", distance = 10, rotation = 90 },
        { name = "middle_bridge", distance = 15, rotation = 180 },
        { name = "middle_hole", distance = 15, rotation = 90 },

        { name = "side_wood1", distance = 20, rotation = 270 },
        { name = "side_wood1", distance = 20, rotation = 0 },

        { name = "middle_hole", distance = 10, rotation = 90 },
        { name = "middle_bridge", distance = 20, rotation = 90 },
        { name = "middle_hole", distance = 30, rotation = 90 },

        --

        { name = "side_wood1", distance = 20, rotation = 90 },
        { name = "corner_hole2", distance = 20, rotation = 0 },
        { name = "side_wood1", distance = 20, rotation = 180 },
        { name = "corner_hole", distance = 15, rotation = 180 },

        -- 18 seconds

        { name = "side_wood1", distance = 20, rotation = 0 },
        { name = "side_wood1", distance = 20, rotation = 180 },
        { name = "side_wood1", distance = 20, rotation = 90 },
        { name = "side_wood1", distance = 20, rotation = 270 },

        { name = "belts", distance = 15, rotation = 0 },
        { name = "middle_bridge", distance = 25, rotation = 90 },

        { name = "side_wood2", distance = 15, rotation = 0 },
        { name = "side_wood2", distance = 15, rotation = 180 },

        { name = "belts", distance = 15, rotation = 90 },
        { name = "middle_bridge", distance = 20, rotation = 180 },
        { name = "belts", distance = 20, rotation = 180 },
        { name = "middle_bridge", distance = 20, rotation = 180 },
        { name = "middle_bridge", distance = 20, rotation = 270 },

        -- 25 seconds

        { name = "middle_hole", distance = 30, rotation = 270 },
        { name = "middle_bridge", distance = 30, rotation = 270 },

        { name = "middle_hole", distance = 30, rotation = 270 },
        { name = "middle_bridge", distance = 30, rotation = 270 },

        { name = "middle_hole", distance = 30, rotation = 270 },
        { name = "middle_bridge", distance = 20, rotation = 0 },
        { name = "middle_hole", distance = 5, rotation = 90 },
        { name = "side_wood1", distance = 15, rotation = 0 },

        --

        { name = "corner_hole", distance = 15, rotation = 0 },
        { name = "side_wood2", distance = 15, rotation = 0 },
        { name = "corner_hole", distance = 15, rotation = 90 },
        { name = "side_wood1", distance = 15, rotation = 90 },
        { name = "corner_hole", distance = 15, rotation = 180 },
        { name = "side_wood2", distance = 15, rotation = 180 },
        { name = "corner_hole", distance = 15, rotation = 0 },

        --

        { name = "belts", distance = 15, rotation = 90 },
        { name = "middle_hole", distance = 15, rotation = 0 },
        { name = "belts", distance = 20, rotation = 180 },
        { name = "side_wood2", distance = 20, rotation = 0 },
        { name = "belts", distance = 20, rotation = 270 },
        { name = "side_wood2", distance = 20, rotation = 90 },
        { name = "belts", distance = 20, rotation = 0 },

        { name = "middle_bridge", distance = 25, rotation = 0 },

        { name = "side_wood2", distance = 25, rotation = 0 },
        { name = "belts", distance = 20, rotation = 270 },
        { name = "side_wood2", distance = 20, rotation = 90 },
        { name = "belt1", distance = 20, rotation = 0 },

        { name = "side_wood1", distance = 20, rotation = 0 },
        { name = "side_wood1", distance = 20, rotation = 180 },

        {name = "minecart", distance = 20, rotation = 0 },

        { name = "side_wood1", distance = 20, rotation = 90 },
        { name = "belts", distance = 10, rotation = 0 },
        { name = "side_wood1", distance = 10, rotation = 270 },

        -- 45 seconds

        {name = "minecart", distance = 20, rotation = 180 },
        {name = "minecart", distance = 20, rotation = 270 },
        {name = "side_wood1", distance = 10, rotation = 0 },
        {name = "middle_bridge", distance = 10, rotation = 0 },
        {name = "minecart", distance = 20, rotation = 90 },
        {name = "middle_hole", distance = 15, rotation = 0 },
        {name = "middle_hole", distance = 5, rotation = 90 },

        {name = "minecart", distance = 20, rotation = 270 },

        {name = "middle_hole", distance = 15, rotation = 0 },
        {name = "middle_hole", distance = 5, rotation = 90 },

        {name = "minecart", distance = 20, rotation = 0 },

        {name = "middle_hole", distance = 15, rotation = 0 },
        {name = "middle_hole", distance = 5, rotation = 90 },

        {name = "minecart", distance = 15, rotation = 180 },
        {name = "corner_hole", distance = 25, rotation = 0 },
        {name = "middle_bridge", distance = 15, rotation = 0 },
        {name = "corner_hole", distance = 20, rotation = 90 },

        { name = "side_wood1", distance = 30, rotation = 0 },

        -- 55 seconds
    },
}