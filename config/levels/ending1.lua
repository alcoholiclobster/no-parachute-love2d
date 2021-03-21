return {
    name = "Getting Out",
    nextLevel = nil,
    music = "ending_theme",

    fallSpeed = 55,
    fogColor = {25, 10, 0},
    fogDistance = 60,
    playerRotationMode = "sinusoid",
    playerRotationSpeed = 0.3,
    playerRotationChangeSpeed = 0.01,

    sidePlanesCount = 80,
    sidePlanesRandomBrightness = false,
    sidePlanesBrightness = 0.99,
    sidePlanes = {
        {
            textures = {
                "levels/meat/side_planes/cave1",
                "levels/meat/side_planes/cave2",
            },
        },
        {
            textures = {
                "levels/meat/side_planes/flesh2",
            },
        },
    },

    planeTypes = {
        stone_breakable_wall = {
            planes = {{ texture = "levels/meat/obstacles/stone_obstacle_breakable", breakable = true }},
        },
        stone_side_long_hole = {
            planes = {
                { texture = "levels/meat/obstacles/stone_obstacle3", },
                { texture = "levels/meat/obstacles/web1", decorative = true, position = {0, 0, 2} },
                { texture = "levels/meat/obstacles/web2", decorative = true, position = {0, 0, 4} },
            },
        },
        stone_long_obstacle = {
            planes = {
                { texture = "levels/meat/obstacles/stone_obstacle5", },
            },
        },
    },

    planes = {
        { distance = 80, name = "stone_long_obstacle" },
        { distance = 20, name = "stone_side_long_hole" },
        { distance = 20, name = "stone_long_obstacle", rotation = 90 },
        { distance = 20, name = "stone_long_obstacle", rotation = 270 },
        { distance = 50, name = "stone_breakable_wall", switchSidePlanes = true },
        { distance = 1500, },
    }
}