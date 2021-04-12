-- keybinds, vad de olika knapparna gör och vilka dessa knappar är

function love.keypressed(k)
  if k == 'escape' then
    love.event.quit()
  elseif k == "r" then 
    love.event.quit("restart")
  elseif k == 's' then
    mainMenu = not mainMenu
  end

  if gameOver == false and mainMenu == false and tutorial == false and k == 'p' then
    pauseGame = not pauseGame 
  elseif gameOver == false and mainMenu == false and pauseGame == false and k == 't' then
    tutorial = not tutorial
  end
end