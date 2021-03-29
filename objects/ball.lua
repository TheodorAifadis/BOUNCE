local world = require('world')

function getBall()
    ball = {}
    ball.body = love.physics.newBody(world, math.random(50, 600), math.random(-50, -600), "dynamic")
    ball.shape = love.physics.newCircleShape(20) -- radius
    ball.fixture = love.physics.newFixture(ball.body, ball.shape, 0) -- density
    return ball
end

ball1 = getBall()
ball2 = getBall()
ball3 = getBall()

return getBall