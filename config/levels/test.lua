return {
    name = "Test level",

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

    },

    planes = {
        { distance = 1 },
        { distance = 150, showText = { label = "Use WASD or arrows to move", duration = 30 }, togglePlayerMovement = false },
        { distance = 150, hideText = true, togglePlayerMovement = true, togglePlayerSpeedUp = false },
        { distance = 1000 },
    },
}