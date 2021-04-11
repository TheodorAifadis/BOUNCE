function love.load()
  love.physics.setMeter(64)
  world = love.physics.newWorld(0, 33*64, true)

  ground = {}
  ground.body = love.physics.newBody(world, 650/2, 650-50/2)
  ground.shape = love.physics.newRectangleShape(650, 50)
  ground.fixture = love.physics.newFixture(ground.body, ground.shape)

  player = {}
  player.body = love.physics.newBody(world, 650/2, 650/2, "dynamic")
  player.shape = love.physics.newCircleShape(20)
  player.fixture = love.physics.newFixture(player.body, player.shape, 1)
  player.fixture:setRestitution(1)

  function getBall(y)
    ball = {}
    ball.body = love.physics.newBody(world, love.math.random(0, 650), y, "kinematic")
    ball.shape = love.physics.newCircleShape(25)
    ball.fixture = love.physics.newFixture(ball.body, ball.shape, 1)
    return ball
  end

  ball1 = getBall(-100)
  ball2 = getBall(-200)
  ball3 = getBall(-300)
  ball4 = getBall(-400)
  ball5 = getBall(-500)

  love.graphics.setBackgroundColor(0, 0, 0)
  love.window.setMode(650, 650)
end