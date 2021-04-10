function love.load()
  love.physics.setMeter(64) -- 1 meter i spelet = 64px
  world = love.physics.newWorld(0, 8.12*64, true) -- gravitationsvariabel * 1 meter i spelet (64px)
  
  ground = {}
  ground.body = love.physics.newBody(world, 650/2, 650-50/2)
  ground.shape = love.physics.newRectangleShape(650, 50)
  ground.fixture = love.physics.newFixture(ground.body, ground.shape)
  
  player = {}
  player.body = love.physics.newBody(world, 650/2, 650/2, "dynamic")
  player.shape = love.physics.newCircleShape(20) -- radie
  player.fixture = love.physics.newFixture(player.body, player.shape, 1) -- densitet
  player.fixture:setRestitution(1) -- studskoefficient

  function getBall(y)
    ball = {}
    ball.body = love.physics.newBody(world, math.random(0, 650), y, "kinematic")
    ball.shape = love.physics.newCircleShape(25) -- radie
    ball.fixture = love.physics.newFixture(ball.body, ball.shape, 1) -- densitet
    ball.body:setLinearVelocity(0, 500)
    return ball
  end

  -- antalet "ballX = getBall(y)" så många bollar kommer att finnas
  ball1 = getBall(-100)
  ball2 = getBall(-200)
  ball3 = getBall(-300)

  love.graphics.setBackgroundColor(0, 0, 0) -- bakgrundsfärg
  love.window.setMode(650, 650) -- spel-fönstrets storlek
end