return {
    name = "Meat 3",
    nextLevel = "ending1",
    music = "meat_theme",

    fallSpeed = 52,
    fogColor = {25, 10, 0},
    fogDistance = 60,
    playerRotationMode = "sinusoid",
    playerRotationSpeed = 0.3,
    playerRotationChangeSpeed = 0.01,

    sidePlanesCount = 70,
    sidePlanesRandomBrightness = false,
    sidePlanesBrightness = 0.99,
    sidePlanes = {
        {
            textures = {
                "levels/meat/side_planes/flesh2",
            },
        },
        {
            textures = {
                "levels/meat/side_planes/cave1",
                "levels/meat/side_planes/cave2",
            },
        },
        {
            textures = {
                "levels/core/side_planes/1",
                "levels/core/side_planes/2",
            },
        },
        {
            textures = {
                "levels/core/side_planes/wide1",
            },
        },
        {
            textures = {
                "levels/meat/side_planes/cave1",
                "levels/meat/side_planes/cave2",
            },
        },
    },

    planeTypes = {
        meat_breakable_wall = {
            planes = {{ texture = "levels/meat/obstacles/meat_wall", breakable = true }},
        },
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

        projectile_rock = {
            planes = {{ texture = "levels/core/projectiles/rock", velocity = {0, 0, 20}, rotationSpeed = 5 }},
        },

        wall = {
            planes = {{ texture = "levels/core/obstacles/wall", decorative = true }},
        },
        portal_wall = {
            planes = {
                { texture = "levels/core/obstacles/portal1", decorative = true, position = {0, 0, 0}, rotationSpeed = 0.2 },
                { texture = "levels/core/obstacles/portal2", decorative = true, position = {0, 0, -1}, rotationSpeed = 0.3 },
                { texture = "levels/core/obstacles/portal3", decorative = true, position = {0, 0, -2}, rotationSpeed = 0.6 },
                { texture = "levels/core/obstacles/portal4", decorative = true, position = {0, 0, -3}, rotationSpeed = 1.0 },
                { texture = "levels/core/obstacles/portal5", decorative = true, position = {0, 0, -4}, rotationSpeed = 1.3 },
                { texture = "levels/core/obstacles/portal6", decorative = true, position = {0, 0, -5}, rotationSpeed = 1.5 },
            },
        },
        fan = {
            planes = {{ texture = "levels/core/obstacles/fan", rotationSpeed = -0.5, }},
        },
        ring = {
            planes = {{ texture = "levels/core/obstacles/ring", rotationSpeed = 7, }},
        },
        long_wall = {
            planes = {{ texture = "levels/core/obstacles/long" }},
        },
        hole = {
            planes = {{ texture = "levels/core/obstacles/hole" }},
        },
    },

    planes = {
        { distance = 100, name = "meat_breakable_wall", switchSidePlanes = true},
        { distance = 60, name = "stone_side_long_hole", },
        { distance = 10, name = "stone_side_long_hole", },
        { distance = 10, name = "stone_side_long_hole", },
        { distance = 5, name = "stone_long_obstacle", rotation = 0, },
        { distance = 5, name = "stone_side_long_hole", },
        { distance = 10, name = "stone_side_long_hole", },
        { distance = 10, name = "stone_side_long_hole", },
        { distance = 5, name = "stone_long_obstacle", rotation = 180, },
        { distance = 5, name = "stone_side_long_hole", },
        { distance = 10, name = "stone_side_long_hole", },
        { distance = 50, name = "stone_side_long_hole", rotation = 180,  },
        { distance = 10, name = "stone_side_long_hole", rotation = 180, },
        { distance = 10, name = "stone_side_long_hole", rotation = 180, },
        { distance = 10, name = "stone_side_long_hole", rotation = 180, },
        { distance = 5, name = "stone_long_obstacle", rotation = 0, },
        { distance = 5, name = "stone_side_long_hole", rotation = 180, },
        { distance = 30, name = "stone_long_obstacle", rotation = 0, },
        { distance = 10, name = "stone_long_obstacle", rotation = 270, },
        { distance = 30, name = "stone_long_obstacle", rotation = 180, },
        { distance = 20, name = "stone_long_obstacle", rotation = 90, },
        { distance = 30, name = "stone_breakable_wall", switchSidePlanes = true},
        { distance = 94, fogColor = {255, 200, 100}, fallSpeed = 80},
        { distance = 20, name = "ring", },
        { distance = 50, name = "projectile_rock", position = {-3.5, -3.5, 0} },
        { distance = 2, name = "projectile_rock", position = {3, 0, 0} },
        { distance = 2, name = "projectile_rock", position = {-3.5, 3, 0} },
        { distance = 2, name = "projectile_rock", position = {0, -3, 0} },

        { distance = 60, tunnelShape = { direction = {0, 0}, rotationSpeed = 1 }, },
        { distance = 10, name = "projectile_rock", position = {0, 0, 0}, rotation = 90 },
        { distance = 80, name = "fan", rotation = 90 },
        { distance = 80, name = "long_wall", },
        { distance = 30, tunnelShape = { direction = {10, 0}, rotationSpeed = -1 }, },
        { distance = 30, name = "ring", },
        { distance = 10, name = "ring", },
        { distance = 10, name = "ring", },
        { distance = 10, name = "ring", },
        { distance = 10, name = "ring", },
        { distance = 10, name = "ring", },
        { distance = 10, name = "ring", },
        { distance = 30, name = "hole"},
        { distance = 30, name = "ring", },
        { distance = 10, name = "ring", },
        { distance = 10, name = "ring", },
        { distance = 10, name = "ring", },
        { distance = 10, name = "ring", },
        { distance = 10, name = "ring", },
        { distance = 10, name = "ring", },

        { distance = 30, tunnelShape = { direction = {0, 10}, rotationSpeed = 0.5 }, },
        { distance = 10, name = "ring", },
        { distance = 10, name = "ring", },
        { distance = 10, name = "ring", },
        { distance = 10, name = "ring", },
        { distance = 10, name = "ring", },
        { distance = 50, tunnelShape = { direction = {-5, 0}, rotationSpeed = 4 }, },
        { distance = 30, name = "ring", },
        { distance = 10, name = "ring", },
        { distance = 10, name = "ring", },
        { distance = 10, name = "ring", },
        { distance = 10, name = "ring", },
        { distance = 50, tunnelShape = { direction = {0, 0}, rotationSpeed = -2 }, },
        { distance = 100, switchSidePlanes = true, name = "wall" },

        { distance = 97, fogColor = {255, 255, 255}, fallSpeed = 20, emit = { name = "stopMusicEvent" }},
        { distance = 1, emit = { name = "playAmbientEvent", args = {"core"} }, togglePlayerSpeedUp = false},
        { distance = 100, name = "portal_wall" },
        { distance = 6 , switchSidePlanes = true},
        { distance = 97, fogColor = {0, 0, 0}, fallSpeed = 120, emit = { name = "stopAmbientEvent" }, togglePlayerSpeedUp = true },
        { distance = 1, emit = { name = "playMusicEvent", args = {"meat_theme"} }},
        { distance = 150, },
    },
}