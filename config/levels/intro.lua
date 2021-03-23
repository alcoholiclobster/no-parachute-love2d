local groundPlanes = {
    textures = {
        "levels/sky/side_plane1",
        "levels/sky/side_plane2"
    },
    pattern = {},
}

return {
    name = "The Jump",
    nextLevel = "tutorial",
    music = "intro",

    disableHud = true,

    fallSpeed = 25,
    fogColor = {124, 213, 255},
    fogDistance = 90,
    playerRotationMode = "none",
    playerRotationSpeed = 0,

    cutscene = "IntroCutscene",

    sidePlanesCount = 60,
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
                { texture = "levels/sky/ground1", },
                { texture = "levels/sky/ground2", position = {0, 0, 1}},
                { texture = "levels/sky/ground3", position = {0, 0, 2}},
                { texture = "levels/sky/ground4", position = {0, 0, 2.75}},
                { texture = "levels/sky/ground5", position = {0, 0, 3.25}},
                { texture = "levels/tutorial/side_plane1", position = {0, 0, -1}, decorative = true},
                { texture = "levels/tutorial/side_plane1", position = {0, 0, -2}, decorative = true},
                { texture = "levels/tutorial/side_plane2", position = {0, 0, -4}, decorative = true},
                { texture = "levels/tutorial/side_plane3", position = {0, 0, -6}, decorative = true},
                { texture = "levels/sky/side_plane4", position = {0, 0, -8}, decorative = true},
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
        { distance = 1, togglePlayerMovement = false, togglePlayerSpeedUp = false, togglePlayerScore = false, },
        { distance = 200, showParachutePrompt = true },
        { distance = 120, showText = { label = "lbl_intro_parachute_missing", duration = 5 }, emit = { name = "stopMusicEvent" } },
        { name = "ground", distance = 170 },
        { switchSidePlanes = true , distance = 10 },
        { distance = 20, showText = { label = "lbl_intro_cave", duration = 5 } },
        { emit = { name = "playMusicEvent", args = {"forest_theme1"} }, distance = 60, togglePlayerMovement = true },
    },
}