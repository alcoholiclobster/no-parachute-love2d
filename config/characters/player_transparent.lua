local size = 2.5

return {
    acceleration = 60,
    friction = 3,

    body = {
        texture = "empty",
        size = { x = size, y = size },
    },

    limbs = {
        hand_right = {
            textures = {
                normal = "empty",
                destroyed = "empty",
            },

            size = { x = size, y = size },
            offset = { x = 0, y = 0, z = -0.1 },

            rotationPoses = {
                left = -0.2,
                right = 0.2,
                up = 0.1,
                down = -0.3,
            },

            collisionOffset = {
                x = 0.5,
                y = -0.5,
                z = 0
            }
        },

        hand_left = {
            textures = {
                normal = "empty",
                destroyed = "empty",
            },

            size = { x = -size, y = size },
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
                normal = "empty",
                destroyed = "empty",
            },

            size = { x = size, y = size },
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
                normal = "empty",
                destroyed = "empty",
            },

            size = { x = -size, y = size },
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