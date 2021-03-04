return {
    name = "Intro",
    nextLevel = "tutorial",

    fallSpeed = 25,
    fogColor = {124, 213, 255},
    fogDistance = 90,
    playerRotationMode = "none",
    playerRotationSpeed = 0,

    sidePlanesCount = 80,
    sidePlanes = {
        {
            textures = {
                "levels/sky/side_plane1",
            },
        },
        {
            textures = {
                "levels/tutorial/side_plane1",
                "levels/tutorial/side_plane2",
                "levels/tutorial/side_plane3",
                "levels/tutorial/side_plane4",
            },
        }
    },

    planeTypes = {
        cloud = {
            planes = {
                { texture = "levels/sky/cloud", },
            },
        },
        ground = {
            planes = {
                { texture = "levels/sky/ground", },
                { texture = "levels/tutorial/side_plane1", position = {0, 0, -1}, decorative = true},
                { texture = "levels/tutorial/side_plane1", position = {0, 0, -2}, decorative = true},
                { texture = "levels/tutorial/side_plane2", position = {0, 0, -4}, decorative = true},
                { texture = "levels/tutorial/side_plane3", position = {0, 0, -6}, decorative = true},
                { texture = "levels/tutorial/side_plane4", position = {0, 0, -8}, decorative = true},
            },
        },
        obstacle1 = {
            planes = {
                { texture = "levels/tutorial/obstacle_plane1", },
            },
        },
        obstacle1_simple = {
            planes = {
                { texture = "levels/tutorial/obstacle_plane1_2", },
            },
        },
        obstacle2 = {
            planes = {
                { texture = "levels/tutorial/obstacle_plane2", },
                { texture = "levels/tutorial/decorative_plane2", decorative = true, position = {0, 0, 5 }},
            },
        },
        obstacle2_simple = {
            planes = {
                { texture = "levels/tutorial/obstacle_plane2_2", },
            },
        },
        obstacle3 = {
            planes = { { texture = "levels/tutorial/obstacle_plane3", }},
        },
        obstacle3_rails = {
            planes = { { texture = "levels/tutorial/obstacle_plane3_2", }},
        },
        obstacle4 = {
            planes = { { texture = "levels/tutorial/obstacle_plane4", }},
        },
        obstacle5 = {
            planes = { { texture = "levels/tutorial/obstacle_plane5", }},
        },
        obstacle6 = {
            planes = { { texture = "levels/tutorial/obstacle_plane6", }},
        },
        obstacle6_broken = {
            planes = { { texture = "levels/tutorial/obstacle_plane6_2", }},
        },
        obstacle7 = {
            planes = { { texture = "levels/tutorial/obstacle_plane7", }},
        },
        breakable1 = {
            planes = { { texture = "levels/tutorial/obstacle_plane8", breakable = true }},
        },
        decorative1 = {
            planes = { { texture = "levels/tutorial/decorative_plane1", decorative = true }},
        },
        decorative2 = {
            planes = { { texture = "levels/tutorial/decorative_plane2", decorative = true }},
        },
    },

    planes = {
        { name = "cloud", distance = 50 },
        { name = "cloud", distance = 50, rotation = 180 },
        { name = "ground", distance = 50 },
        { switchSidePlanes = true , distance = 10 },
        { distance = 1000 },
        { name = "decorative2", distance = 50, rotation = 90 },
        { name = "decorative1", distance = 50, rotation = 180 },
        { name = "decorative2", distance = 30, rotation = 0 },
        { name = "decorative1", distance = 10, rotation = 180 },
        { name = "obstacle1_simple", distance = 10, rotation = 0 },
        { name = "decorative2", distance = 30, rotation = 0 },
        { name = "obstacle1", distance = 10, rotation = 180 },

        { name = "decorative1", distance = 100, rotation = 0 },
        { name = "breakable1", distance = 50, rotation = 0 },
        { name = "obstacle6", distance = 50, rotation = 180 },
        { name = "decorative2", distance = 45, rotation = 0 },
        { name = "obstacle6", distance = 5, rotation = 0 },

        { name = "obstacle2_simple", distance = 50, rotation = 0 },
        { name = "obstacle6", distance = 15, rotation = 270 },
        { name = "decorative1", distance = 15, rotation = 0 },
        { name = "obstacle1", distance = 10, rotation = 90 },
        { name = "obstacle6", distance = 20, rotation = 90 },
        { name = "obstacle1_simple", distance = 20, rotation = 270 },

        { name = "obstacle6_broken", distance = 75, rotation = 0 },
        { name = "obstacle7", distance = 60, rotation = 90 },
        { name = "obstacle2", distance = 12, rotation = 90 },

        { name = "obstacle3", distance = 30, rotation = 0 },
        { name = "obstacle4", distance = 40, rotation = 0 },
        { name = "obstacle3", distance = 30, rotation = 270 },
        { name = "obstacle3_rails", distance = 50, rotation = 180 },
        { name = "obstacle4", distance = 30, rotation = 90 },
        { name = "obstacle1_simple", distance = 30, rotation = 270 },

        { name = "obstacle1", distance = 60, rotation = 270 },
        { name = "obstacle1_simple", distance = 25, rotation = 180 },
        { name = "obstacle2", distance = 30, rotation = 90 },
        { name = "obstacle1_simple", distance = 20, rotation = 0 },
        { name = "obstacle1", distance = 30, rotation = 180 },
        { name = "obstacle5", distance = 20, rotation = 0 },
        { name = "obstacle4", distance = 20, rotation = 270 },
        { name = "obstacle1", distance = 20, rotation = 90 },
        { name = "obstacle5", distance = 20, rotation = 90 },

        { name = "obstacle7", distance = 30, rotation = 90 },
        { name = "obstacle3_rails", distance = 30, rotation = 90 },
        { name = "obstacle4", distance = 40, rotation = 0 },
        { name = "obstacle4", distance = 30, rotation = 90 },
        { name = "obstacle4", distance = 30, rotation = 180 },
        { name = "obstacle7", distance = 40, rotation = 0 },
    },
}