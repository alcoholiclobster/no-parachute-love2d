return {
    acceleration = 50,
    friction = 3,

    body = {
        texture = "characters/player/torso",
        size = { x = 2.5, y = 2.5 },
    },

    limbs = {
        hand_right = {
            textures = {
                normal = "characters/player/hand",
                destroyed = "characters/player/hand_missing"
            },

            size = { x = 2.5, y = 2.5 },
            offset = { x = 0, y = 0, z = -0.1 },

            rotationPoses = {
                left = -0.2,
                right = 0.2,
                up = 0.1,
                down = -0.3,
            },

            collisionOffset = {
                x = 0.5,
                y = 0.5,
                z = 0
            }
        },

        hand_left = {
            textures = {
                normal = "characters/player/hand",
                destroyed = "characters/player/hand_missing2"
            },

            size = { x = -2.5, y = 2.5 },
            offset = { x = -0.08, y = 0, z = -0.1 },

            rotationPoses = {
                left = -0.2,
                right = 0.2,
                up = -0.1,
                down = 0.3,
            },

            collisionOffset = {
                x = -0.5,
                y = -0.5,
                z = 0
            }
        },

        leg_right = {
            textures = {
                normal = "characters/player/leg",
                destroyed = "characters/player/leg_missing"
            },

            size = { x = 2.5, y = 2.5 },
            offset = { x = 0, y = 0, z = -0.1 },

            rotationPoses = {
                left = -0.2,
                right = 0.2,
                up = 0.2,
                down = -0.25,
            },

            collisionOffset = {
                x = 0.18,
                y = 0.5,
                z = 0
            }
        },

        leg_left = {
            textures = {
                normal = "characters/player/leg",
                destroyed = "characters/player/leg_missing2"
            },

            size = { x = -2.5, y = 2.5 },
            offset = { x = -0.08, y = 0, z = -0.1 },

            rotationPoses = {
                left = -0.2,
                right = 0.2,
                up = -0.2,
                down = 0.25,
            },

            collisionOffset = {
                x = -0.18,
                y = 0.5,
                z = 0
            }
        },
    }
}