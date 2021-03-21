return {
    name = "Getting Out",
    nextLevel = nil,
    music = "ending_theme",

    fallSpeed = 55,
    fogColor = {25, 10, 0},
    fogDistance = 60,
    playerRotationMode = "sinusoid",
    playerRotationSpeed = -0.3,
    playerRotationChangeSpeed = 0.012,

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
        {
            textures = {
                "levels/meat/side_planes/flesh1",
                "levels/meat/side_planes/flesh2",
            },
        },
        {
            textures = {
                "levels/vents/decorative1",
                "levels/vents/decorative2",
                "levels/vents/decorative3",
            }
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
        meat_half_wall = {
            planes = {
                { texture = "levels/meat/obstacles/meat_decorative_corner_things2", position = {0, 0, 1}, rotation = 180, decorative = true },
                { texture = "levels/meat/obstacles/meat_obstacle_half3", position = {0, 0, 0} },
                { texture = "levels/meat/obstacles/meat_obstacle_half3_2", position = {0, 0, -0.2}, decorative1 = true},
                { texture = "levels/meat/obstacles/meat_obstacle_half2", position = {0, 0, -2} },
                { texture = "levels/meat/obstacles/meat_obstacle_half", position = {0, 0, -4} },
                { texture = "levels/meat/obstacles/meat_obstacle_half_2", position = {0, 0, -4.1}, decorative = true },
            },
        },
        meat_wall = {
            planes = {
                { texture = "levels/meat/obstacles/meat_wall", breakable = true }
            },
        },
        meat_long_middle_thing = {
            planes = {
                { texture = "levels/meat/obstacles/long_meat_middle_thing" },
                { texture = "levels/meat/obstacles/long_meat_middle_thing2", position = {0, 0, -0.25}, decorative = true },
            },
        },

        vents_middle_long_stick = {
            planes = {
                { texture = "levels/vents/long_stick", position = {0, 0, 0}, rotation = 180 },
            }
        },
        vents_middle_door = {
            planes = {
                { texture = "levels/vents/middle_door_frame" },
                { texture = "levels/vents/middle_door", position = {0, 0, -0.5}, velocity = {-8, 0, 0}, moveDelay = 1, },
            },
        },
    },

    planes = {
        { distance = 80, name = "stone_long_obstacle" },
        { distance = 20, name = "stone_side_long_hole" },
        { distance = 20, name = "stone_long_obstacle", rotation = 90 },
        { distance = 20, name = "stone_long_obstacle", rotation = 270 },
        { distance = 50, name = "stone_breakable_wall", switchSidePlanes = true },
        { distance = 50, name = "meat_half_wall" },
        { distance = 30, name = "meat_half_wall", rotation = 180 },
        { distance = 6, name = "meat_wall", switchSidePlanes = true },
        { distance = 25, name = "vents_middle_long_stick", rotation = 90 },
        { distance = 20, name = "meat_half_wall" },
        { distance = 10, name = "meat_long_middle_thing", rotation = 90},
        { distance = 10, name = "meat_half_wall", rotation = 90},
        { distance = 30, name = "meat_wall" },

        { distance = 30, name = "vents_middle_door", switchSidePlanes = true, },
        { distance = 100, },
    }
}