-- variables
gameOver = false
greenFont = {0, 1, 0, 1}
bigFont = love.graphics.newFont("assets/Stick-Regular.ttf", 100)
smallFont = love.graphics.newFont("assets/Stick-Regular.ttf", 25)
score = 0
bounceSfx = love.audio.newSource("assets/bounce.mp3", "static")
bounceSfx:setVolume(0.5)
math.randomseed(os.time())

function love.load()
  -- physics, gravity
  love.physics.setMeter(64)
  world = love.physics.newWorld(0, 9.84*64, true)

  -- the following are objects, to which i apply physics
  ground = {}
  ground.body = love.physics.newBody(world, 650/2, 650-50/2)
  ground.shape = love.physics.newRectangleShape(650, 50)
  ground.fixture = love.physics.newFixture(ground.body, ground.shape)

  player = {}
  player.body = love.physics.newBody(world, 650/2, 650/2, "dynamic")
  player.shape = love.physics.newCircleShape(20) -- radius
  player.fixture = love.physics.newFixture(player.body, player.shape, 1) -- density
  player.fixture:setRestitution(1) -- bounce

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

  -- backgroundcolor and window-size
  love.graphics.setBackgroundColor(0, 0, 0)
  love.window.setMode(650, 650)
end

-- function used to check collision between two objects
function checkCollission(fixture1, fixture2, distance)
  if love.physics.getDistance(fixture1,fixture2) < distance then
    return true
  end
end

function love.update(dt)
  world:update(dt)

  -- if gameOver is true then the game ends
  if gameOver then
    return 
  end

  -- the score is based on ticks
  score = score + 1

  -- movement, based on applying force on the object (player in this case)
  if love.keyboard.isDown("right") then 
    player.body:applyForce(500, 0)
  elseif love.keyboard.isDown("left") then 
    player.body:applyForce(-500, 0)
  end

  -- the following statements is made to send the ball to the other side of the screen when it gets 
  -- out on the other side
  playerPosition = player.body:getX( )
  
  if playerPosition < 0 then
    player.body.setX(player.body, 650)
  end

  if playerPosition > 650 then
    player.body.setX(player.body, 0)
  end

  -- here i am using the checkCollission function to check if the ball touches the player and if so the game ends
  function destroyPlayer(ball)
    if checkCollission(player.fixture, ball.fixture, 1) then
      gameOver = true
     end
  end

  destroyPlayer(ball1)
  destroyPlayer(ball2)
  destroyPlayer(ball3)

  function playSound(sound)
    sound:play()
  end

  if checkCollission(player.fixture, ground.fixture, 10) then
    playSound(bounceSfx)
   end

  ballPosition = ball1.body:getY( )
  ballPosition = ball1.body:getX( )

  function respawnBall(ball)
    if checkCollission(ground.fixture, ball.fixture, 1) then
      ball.body.setY(ball.body, -50)
      ball.body.setX(ball.body, math.random(10, 500))
     end
  end

  respawnBall(ball1)
  respawnBall(ball2)
  respawnBall(ball3)

  -- close and restart game keybinds
  function love.keypressed(k)
    if k == 'escape' then
      love.event.quit()
    end
    if k == "r" then 
      love.event.quit("restart") 
    end
  end
end

-- function for text and colors
function love.draw()
  love.graphics.print({greenFont, (score)}, smallFont, 50, 50)
  
  if gameOver == false then
    love.graphics.print({greenFont, ("BOUNCE")}, bigFont, 125, 150)
  end

  if (gameOver) then
    love.graphics.print({greenFont, ("GAME")}, bigFont, 190, 150)
    love.graphics.print({greenFont, ("OVER")}, bigFont , 203, 250)
    love.graphics.print({greenFont, ("R TO RESTART")}, smallFont, 253, 400)
    love.graphics.print({greenFont, ("ESC TO EXIT")}, smallFont, 266, 450)
    return
  end
  
  love.graphics.setColor(0, 1, 0)
  love.graphics.polygon("fill", ground.body:getWorldPoints(ground.shape:getPoints()))

  function ballColor(ball)
  love.graphics.setColor(1, 0, 0)
  love.graphics.circle("fill", ball.body:getX(), ball.body:getY(), ball.shape:getRadius())
  end

  ballColor(ball1)
  ballColor(ball2)
  ballColor(ball3)

  love.graphics.setColor(1, 1, 1)
  love.graphics.circle("fill", player.body:getX(), player.body:getY(), player.shape:getRadius())
end
