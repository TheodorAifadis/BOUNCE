gameOver = false
greenFont = {0, 1, 0, 1}
enemies = 9
enemyPosition = {}
enemiesSpawned = {}

function love.load()
  love.physics.setMeter(64)
  world = love.physics.newWorld(0, 9.82*64, true)

  ground = {}
  ground.body = love.physics.newBody(world, 650/2, 650-50/2)
  ground.shape = love.physics.newRectangleShape(650, 50)
  ground.fixture = love.physics.newFixture(ground.body, ground.shape)

  leftWall = {}
  leftWall.body = love.physics.newBody(world, 1, 650-50/2)
  leftWall.shape = love.physics.newRectangleShape(50, 1300)
  leftWall.fixture = love.physics.newFixture(leftWall.body, leftWall.shape)

  rightWall = {}
  rightWall.body = love.physics.newBody(world, 649, 650-50/2)
  rightWall.shape = love.physics.newRectangleShape(50, 1300)
  rightWall.fixture = love.physics.newFixture(rightWall.body, rightWall.shape)

  player = {}
  player.body = love.physics.newBody(world, 650/2, 650/2, "dynamic")
  player.shape = love.physics.newCircleShape(20) -- radie
  player.fixture = love.physics.newFixture(player.body, player.shape, 1) -- densitet
  player.fixture:setRestitution(1) -- studskoefficient

  love.graphics.setBackgroundColor(0, 0, 0)
  love.window.setMode(650, 650)
end

function checkCollission(fixture1, fixture2)
  if love.physics.getDistance(fixture1,fixture2) == 0 then
    return true
  end
end

function love.update(dt)
  world:update(dt)

  if gameOver then
    return 
  end

  if love.keyboard.isDown("right") then 
    player.body:applyForce(400, 0)
  elseif love.keyboard.isDown("left") then 
    player.body:applyForce(-400, 0)
  end

  enemiesSpawned = 0
  for i = 1, #enemyPosition do enemiesSpawned = enemiesSpawned + 1 end
    i = enemiesSpawned
  if enemiesSpawned < enemies then
    while i <= enemies do
      ball = {}
      ball.body = love.physics.newBody(world, math.random(6, 600), math.random(-50, -500), "dynamic")
      ball.shape = love.physics.newCircleShape(20) -- radie
      ball.fixture = love.physics.newFixture(ball.body, ball.shape, 1) -- densitet
      ball.fixture:setRestitution(math.random(1, 1.5)) -- studskoefficient
      enemyPosition[i] = ball
        i = i + 1
      end
    end
    for i = 1, #enemyPosition do 
      if checkCollission(player.fixture, enemyPosition[i].fixture) then
        gameOver = true
      end
    
    for i = 1, #enemyPosition do 
      if checkCollission(enemyPosition[i].fixture, ground.fixture) then
        enemyPosition[i] = table.remove(enemyPosition, i)
      end
    end
  end

  function love.keypressed(k)
    if k == 'escape' then
      love.event.quit()
    end
    if k == "r" then 
      love.event.quit("restart") 
    end
  end
end

function love.draw()
  if (gameOver) then
    love.graphics.print({greenFont, ("R TO RESTART")}, 290, 300)
    return
end
  
  love.graphics.setColor(.1, 0, 0)
  love.graphics.polygon("fill", leftWall.body:getWorldPoints(leftWall.shape:getPoints()))

  love.graphics.setColor(.1, 0, 0)
  love.graphics.polygon("fill", rightWall.body:getWorldPoints(rightWall.shape:getPoints()))
  
  love.graphics.setColor(.1, 0, 0)
  love.graphics.polygon("fill", ground.body:getWorldPoints(ground.shape:getPoints()))

  love.graphics.setColor(1, 0, 0)
  love.graphics.circle("fill", ball.body:getX(), ball.body:getY(), ball.shape:getRadius())

  for i = 1, #enemyPosition do
    love.graphics.setColor(1, 0, 0)
    love.graphics.circle("fill", enemyPosition[i].body:getX(), enemyPosition[i].body:getY(), enemyPosition[i].shape:getRadius())
  end

  love.graphics.setColor(1, 1, 1)
  love.graphics.circle("fill", player.body:getX(), player.body:getY(), player.shape:getRadius())
end
