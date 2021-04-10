function love.update(dt)
    -- om någon av nedanstående variebler är true så returnas dessa "funktion" (ej funktion som i function)
  if gameOver or pauseGame or tutorial or mainMenu then
    return
  end
    
  world:update(dt) -- denna måste stå under ovanstående if-sats för att gameOver och liknande ska fungera

  score = score + 1 

  if love.keyboard.isDown("right") then 
    player.body:applyForce(500, 0) -- på grund av att jag använder mig utav love.physics 
                                   -- så förfölyttas bollen genom att placera kraft från en axel på bollen
  elseif love.keyboard.isDown("left") then 
    player.body:applyForce(-500, 0)
  end
  
  playerPosition = player.body:getX( ) -- endast en variabel för att ta fram spelarens X-position
    
  -- om spelaren hamnar utanför skärmen så teleporteras spelaren bort till andra sidan av skärmen
  if playerPosition < 0 then
    player.body.setX(player.body, 650)
  elseif playerPosition > 650 then
    player.body.setX(player.body, 0)
  end
  
  --  med hjälp av den tidigare kollisionsfunktionen så fungerar denna på så sätt att om spelaren och en boll 
  -- "kolliderar" så är gameOver = true
  function endGame(ball)
    if checkCollission(player.fixture, ball.fixture, 5) then
      gameOver = true
    end
  end
  
  -- likt tidigare så kallar jag detta kommande så många gånger med antalet bollar
  -- "ballX = getBall(Y)", som tidigare
  endGame(ball1)
  endGame(ball2)
  endGame(ball3)
  
  -- om spelet är igång så spelas musiken, om spelet är slut (gameOver) så slutar musiken
  if gameOver == false then
    music:play()
  elseif gameOver == true then
    music:setVolume(0)
  end
  
  -- studsandet spelas i en slumpmässig pitch
  function playSound(sound)
    sound:play()
    sound:setPitch(.85)
  end
  
  -- om bollen "kolliderar" med marken, studsar, så spelas ett studs-ljud upp
  if checkCollission(player.fixture, ground.fixture, 1) then
    playSound(bounceSfx)
  end
  
  -- om en röd boll "kolliderar" med marken så "respawnas" den
  -- den "respawnar" genom att flyttas upp till 100px ovanflr skärmen
  function respawnBall(ball)
    if checkCollission(ground.fixture, ball.fixture, 1) then
      ball.body.setY(ball.body, -50)
      ball.body.setX(ball.body, math.random(0, 650))
    end
  end
  
  respawnBall(ball1)
  respawnBall(ball2)
  respawnBall(ball3)
end