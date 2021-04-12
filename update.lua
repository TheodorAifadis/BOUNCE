function love.update(dt)
  if gameOver or pauseGame or tutorial or mainMenu then -- det här måste stå ovanför world:update(dt) för att
    return                                              -- dess funktion ska fungera, spelet tar slut, pausas
  end

  world:update(dt)

  score = score + 1

  ball1.body:setLinearVelocity(0, 250 * x)
  ball2.body:setLinearVelocity(0, 250 * x)
  ball3.body:setLinearVelocity(0, 250 * x)
  ball4.body:setLinearVelocity(0, 250 * x)
  ball5.body:setLinearVelocity(0, 250 * x)

  x = x + 0.0005

  if love.keyboard.isDown("right") then
    player.body:applyForce(500, 0)
  elseif love.keyboard.isDown("left") then
    player.body:applyForce(-500, 0)
  end

  playerPosition = player.body:getX( )

  if playerPosition < 0 then
    player.body.setX(player.body, 650)
  elseif playerPosition > 650 then
    player.body.setX(player.body, 0)
  end

  function endGame(ball)
    if checkCollission(player.fixture, ball.fixture, 10) then
      gameOver = true
      if(tonumber(highscore) < score) then -- om man får mer poäng än highscore så ersätts highscore värdet
        highscore = score                  -- med det poäng man precis fått
        saveHighScore(highscore)
      end
    end
  end

  endGame(ball1)
  endGame(ball2)
  endGame(ball3)
  endGame(ball4)
  endGame(ball5)

  if gameOver == false then
    music:play()
  elseif gameOver == true then
    music:setVolume(0)
    gameOverSound:play()
  end

  if score == 500 or score == 1000 or score == 1500 or score == 2000 then
    levelSound:play() 
  end

  function respawnBall(ball)
    if checkCollission(ground.fixture, ball.fixture, 10) then
      ball.body.setY(ball.body, -10)
      ball.body.setX(ball.body, love.math.random(0, 650))
    end
  end

  respawnBall(ball1)
  respawnBall(ball2)
  respawnBall(ball3)
  respawnBall(ball4)
  respawnBall(ball5)
end