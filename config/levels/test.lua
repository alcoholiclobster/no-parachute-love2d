return {
    name = "Test level",

    -- finishCutscene = "EndingCutscene",

    fallSpeed = 25,
    fogColor = {0, 5, 10},
    fogDistance = 70,
    playerRotationMode = "none",
    playerRotationSpeed = 0,

    highscores = {
        500,
        999999999,
    },

    sidePlanesCount = 80,
    sidePlanesRandomBrightness = true,
    sidePlanesBrightness = 0.7,
    sidePlanes = {
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
        obstacle_half_plane = {
            planes = { { texture = "levels/deep_forest/obstacle_plane6", }},
        },
    },

    planes = {
        { distance = 100, name = "obstacle_half_plane" },
    },
}