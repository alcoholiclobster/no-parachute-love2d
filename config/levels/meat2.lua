return {
    name = "Flesh Hell 2",
    nextLevel = nil,
    music = "meat_theme",

    fallSpeed = 50,
    fogColor = {25, 10, 0},
    fogDistance = 90,
    playerRotationMode = "sinusoid",
    playerRotationSpeed = 0.3,
    playerRotationChangeSpeed = 0.01,

    sidePlanesCount = 60,
    sidePlanesRandomBrightness = true,
    sidePlanesBrightness = 0.95,
    sidePlanes = {
        {
            textures = {
                "levels/meat/side_planes/flesh1",
                "levels/meat/side_planes/flesh2",
            },
        },
        {
            textures = {
                "levels/meat/side_planes/flesh_small",
            },
        },
        {
            textures = {
                "levels/meat/side_planes/flesh_wide",
            },
        },
        {
            textures = {
                "levels/meat/side_planes/flesh_wide2",
            },
        },
        {
            textures = {
                "levels/meat/side_planes/flesh1",
                "levels/meat/side_planes/flesh2",
            },
        },
    },

    planeTypes = {
        meat_long_thing1 = {
            planes = {
                { texture = "levels/meat/obstacles/long_meat_middle_thing" },
                { texture = "levels/meat/obstacles/meat_decorative_corner_things", decorative = true, position = {0, 0, -1} },
            },
        },
        meat_long_thing2 = {
            planes = {
                { texture = "levels/meat/obstacles/meat_long_obstacle2" },
            },
        },
        meat_long_thing3 = {
            planes = {
                { texture = "levels/meat/obstacles/meat_long_obstacle3" },
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
        meat_small_transition_wall = {
            planes = {
                { texture = "levels/meat/obstacles/meat_decorative_corner_things2", position = {0, 0, 2}, decorative = true },
                { texture = "levels/meat/obstacles/meat_small_transition_wall" },
                { texture = "levels/meat/side_planes/flesh_small", position = {0, 0, -2}, rotation = 90 },
                { texture = "levels/meat/side_planes/flesh_small", position = {0, 0, -4}, rotation = 0 },
                { texture = "levels/meat/side_planes/flesh_small", position = {0, 0, -6}, rotation = 180 },
                { texture = "levels/meat/side_planes/flesh_small", position = {0, 0, -8}, rotation = 270 },
            }
        },
        meat_big_holes = {
            planes = {
                { texture = "levels/meat/obstacles/meat_big_deco_corner_things", position = {0, 0, 2}, decorative = true },
                { texture = "levels/meat/obstacles/meat_big_holes3" },
                { texture = "levels/meat/obstacles/meat_big_holes2", position = {0, 0, -2} },
                { texture = "levels/meat/obstacles/meat_big_holes", position = {0, 0, -4} },
            }
        },
        meat_big_hole = {
            planes = {
                { texture = "levels/meat/obstacles/meat_big_hole" },
            }
        },
        eye_ball = {
            planes = {
                { texture = "levels/meat/obstacles/eye_ball_holder", position = {0, 0, -1.8} },
                { texture = "levels/meat/obstacles/eye_ball1", position = {0, 0, -1.75} },
                { texture = "levels/meat/obstacles/eye_ball2", position = {0, 0, -1.5} },
                { texture = "levels/meat/obstacles/eye_ball3", position = {0, 0, -1} },
                { texture = "levels/meat/obstacles/eye_ball4", position = {0, 0, 0} },
            }
        },
        meat_decorative_corner = {
            planes = {
                { texture = "levels/meat/obstacles/meat_decorative_corner_things", decorative = true }
            }
        },
        meat_big_obstacle = {
            planes = {
                { texture = "levels/meat/obstacles/meat_big_obstacle" }
            }
        },
        meat_big_obstacle_middle = {
            planes = {
                { texture = "levels/meat/obstacles/meat_big_obstacle_middle" },
                { texture = "levels/meat/obstacles/meat_big_obstacle_middle2", position = {0, 0, -0.1}, decorative = true }
            }
        },
        worm1_big = {
            planes = {
                { texture = "levels/meat/obstacles/worm1", rotationSpeed = 1 }
            }
        },
        worm1_big_head = {
            planes = {
                { texture = "levels/meat/obstacles/worm1_head", rotationSpeed = 1 }
            }
        },
        worm1_wall = {
            planes = {
                { texture = "levels/meat/obstacles/worm_wall", position = {0, 0, 0} },
                { texture = "levels/meat/obstacles/worm_wall", position = {0, 0, -2}, rotation = 90 }
            }
        },
        meat_big_hole_to_normal = {
            planes = {
                { texture = "levels/meat/obstacles/meat_big_holes_to_normal" },
                { texture = "levels/meat/side_planes/flesh1", position = {0, 0, -2}, rotation = 90 },
                { texture = "levels/meat/side_planes/flesh2", position = {0, 0, -4}, rotation = 0 },
                { texture = "levels/meat/side_planes/flesh1", position = {0, 0, -6}, rotation = 180 },
                { texture = "levels/meat/obstacles/meat_decorative_corner_things", position = {0, 0, -7}, decorative = true },
                { texture = "levels/meat/side_planes/flesh2", position = {0, 0, -8}, rotation = 270 },
            }
        },
        meat_big_hole_middle = {
            planes = {
                { texture = "levels/meat/obstacles/meat_big_holes_to_normal" },
                { texture = "levels/meat/obstacles/meat_decorative_corner_things", position = {0, 0, -0.01}, decorative = true },
                { texture = "levels/meat/obstacles/meat_wall", position = {0, 0, -0.02}, breakable = true },
            }
        }
    },

    planes = {
        { distance = 100, tunnelShape = { direction = {0, 2}, rotationSpeed = 2 },},
        { distance = 1, name = "meat_half_wall" },
        { distance = 1, name = "meat_decorative_corner", rotation = 180, },
        { distance = 10, name = "meat_long_thing2", rotation = 90, },
        { distance = 10, name = "meat_long_thing3" },
        { distance = 10, name = "meat_long_thing2", rotation = 90 },
        { distance = 10, name = "meat_long_thing3" },
        { distance = 1, name = "meat_decorative_corner", rotation = 180, },
        { distance = 10, name = "meat_long_thing1" },
        { distance = 10, name = "meat_half_wall", rotation = 0 },
        { distance = 10, name = "meat_long_thing2", rotation = 90 },
        { distance = 10, name = "meat_long_thing3" },
        { distance = 10, name = "meat_long_thing2", rotation = 0 },
        { distance = 10, name = "meat_long_thing2", rotation = 180 },
        { distance = 5, name = "meat_decorative_corner", rotation = 90, },
        { distance = 1, name = "meat_decorative_corner", rotation = 270, },
        { distance = 5, name = "meat_small_transition_wall", },
        { distance = 10, switchSidePlanes = true, tunnelShape = { direction = {0, 8}, rotationSpeed = 0.6 }, },
        { distance = 100, switchSidePlanes = true, tunnelShape = { direction = {0, 1}, rotationSpeed = 0.2 }, },
        { distance = 50, name = "meat_big_holes", },
        { distance = 30, name = "meat_big_obstacle", },
        { distance = 30, name = "meat_big_obstacle_middle", },
        { distance = 10, name = "meat_big_obstacle", },
        { distance = 40, name = "meat_big_hole_middle" },
        { distance = 10, switchSidePlanes = true},

        { distance = 150, name = "worm1_wall"},
        { distance = 1, name = "worm1_big", position = {10, 10, 0}},

        { distance = 40, name = "worm1_wall" },
        { distance = 1, name = "worm1_big", position = {-8, 8, 0}, rotation = 180},

        { distance = 30, name = "worm1_wall" },
        { distance = 1, name = "worm1_big", position = {15, 15, 0}, rotation = 180},

        { distance = 30, name = "worm1_wall" },
        { distance = 1, name = "worm1_big_head", position = {15, 0, 0}},

        { distance = 40, name = "meat_big_hole_to_normal" },
        { distance = 10, switchSidePlanes = true },

        { distance = 100 },
    },
}