greenFont = {0, 1, 0, 1}
bigFont = love.graphics.newFont("assets/Stick-Regular.ttf", 100)
smallFont = love.graphics.newFont("assets/Stick-Regular.ttf", 25)
score = 0
bounceSfx = love.audio.newSource("assets/bounce.mp3", "static")
bounceSfx:setVolume(0.5)
math.randomseed(os.time())

function love.load()
  sleep = 0

  ball = require('objects/ball')
  ground = require('objects/ground')
  player = require('objects/player')

  love.graphics.setBackgroundColor(0, 0, 0)
  love.window.setMode(650, 650)
end

function checkCollission(fixture1, fixture2, distance)
  if love.physics.getDistance(fixture1,fixture2) < distance then
    return true
  end
end

function love.update(dt)
  world:update(dt)

  love.timer.sleep(sleep)

  if love.timer.getFPS()>60 then
    sleep = sleep + 0.0001 
  end

  if gameOver then
    return 
  end

  score = score + 1

  if love.keyboard.isDown("right") then 
    player.body:applyForce(500, 0)
  elseif love.keyboard.isDown("left") then 
    player.body:applyForce(-500, 0)
  end

  playerPosition = player.body:getX( )
  
  if playerPosition < 0 then
    player.body.setX(player.body, 650)
  end

  if playerPosition > 650 then
    player.body.setX(player.body, 0)
  end

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

  function love.keypressed(k)
    if k == 'escape' then
      love.event.quit()
    end
    if k == "r" then 
      love.event.quit("restart") 
    end
    if k == 'm' then
      bounceSfx:setVolume(0)
    end
    if k == 'n' then
      bounceSfx:setVolume(.5)
    end
  end
end

function love.draw()
  love.graphics.print({greenFont, ("SCORE:")}, smallFont, 25, 50)
  love.graphics.print({greenFont, (score)}, smallFont, 125, 50)
  
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
