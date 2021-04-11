function love.draw()
  if gameOver or tutorial or mainMenu == false then
    love.graphics.print({greenFont, ("Score:")}, smallFont, 25, 60)
    love.graphics.print({greenFont, (score)}, smallFont, 100, 60)
  end

  if mainMenu == false and gameOver == false and pauseGame == false then
    love.graphics.print({greenFont, ("Press T For Tutorial")}, miniFont, 475, 50)
  end

  if gameOver == true then
    love.graphics.print({greenFont, ("Game")}, bigFont, 200, 150)
    love.graphics.print({greenFont, ("Over")}, bigFont , 220, 250)
    love.graphics.print({greenFont, ("R To Restart")}, smallFont, 256, 400)
    love.graphics.print({greenFont, ("Esc To Exit")}, smallFont, 266, 450)
    return
  elseif pauseGame == true then
    love.graphics.print({greenFont, ("BOUNCE")}, bigFont , 110, 150)
    love.graphics.print({greenFont, ("The Game Is Paused")}, smallFont , 210, 300)
    love.graphics.print({greenFont, ("Press P To Continue")}, smallFont , 210, 350)
    return
  elseif mainMenu == true then
    love.graphics.print({greenFont, ("Welcome To")}, smallFont , 250, 150)
    love.graphics.print({greenFont, ("BOUNCE")}, bigFont , 110, 200)
    love.graphics.print({greenFont, ("Press S To Start The Game")}, smallFont , 170, 400)
    return
  elseif tutorial == true then
    love.graphics.setColor(0, 1, 0)
    love.graphics.print({greenFont, ("BOUNCE")}, bigFont , 110, 130)
    love.graphics.print({greenFont, ("T To Continue")}, smallFont , 145, 300)
    love.graphics.rectangle('line', 139, 305, 30, 30)
    love.graphics.print({greenFont, ("Esc To Exit")}, smallFont , 345, 300)
    love.graphics.rectangle('line', 339, 305, 54, 30)
    love.graphics.print({greenFont, ("R To Restart")}, smallFont , 145, 360)
    love.graphics.rectangle('line', 139, 365, 30, 30)
    love.graphics.print({greenFont, ("P To Pause")}, smallFont , 345, 360)
    love.graphics.rectangle('line', 339, 365, 30, 30)
    love.graphics.print({greenFont, ("M To Mute")}, smallFont , 145, 420)
    love.graphics.rectangle('line', 139, 425, 35, 30)
    love.graphics.print({greenFont, ("U To Unmute")}, smallFont , 345, 420)
    love.graphics.rectangle('line', 339, 425, 30, 30)
    love.graphics.print({greenFont, ("Arrows To Move Sideways")}, smallFont , 170, 479)
    return
  end

  if score > 500 and score < 1000 then
    love.graphics.print({greenFont, ("Nice!")}, smallFont , 50, 100)
  elseif score > 1000 and score < 1500 then
    love.graphics.print({greenFont, ("Great!")}, smallFont , 50, 100)
  elseif score > 1500 and score < 2000 then
    love.graphics.print({greenFont, ("Epic!")}, smallFont , 50, 100)
  elseif score > 2000 then
    love.graphics.draw(image, 10, 100, 0, 0.2, 0.2)
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
  ballColor(ball4)
  ballColor(ball5)

  love.graphics.setColor(1, 1, 1)
  love.graphics.circle("fill", player.body:getX(), player.body:getY(), player.shape:getRadius())
end