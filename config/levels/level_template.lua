return {
    name = "CHANGE ME",

    fallSpeed = 27,
    fogColor = {0, 20, 31},
    playerRotationMode = "sinusoid",
    playerRotationSpeed = 0.2,
    playerRotationChangeSpeed = 0.02,

    sidePlanesCount = 40,
    sidePlanes = {
        {
            textures = {
                "levels/level1_1/side_plane1",
                "levels/level1_1/side_plane2",
                "levels/level1_1/side_plane3",
            },
        },
    },

    planeTypes = {
        obstacle_center_hole = {
            planes = { { texture = "levels/level1_1/obstacle_plane2", }},
        },
    },

    planes = {
        { name = "obstacle_center_hole", distance = 500, rotation = 0 },
    },
}