-- om en knapp trycks ner så sker något
function love.keypressed(k)
  if k == 'escape' then
    love.event.quit()
  elseif k == "r" then 
    love.event.quit("restart")
  elseif k == 'p' then
    pauseGame = not pauseGame 
  elseif k == 's' then
    mainMenu = not mainMenu
  elseif k == 't' then
    tutorial = not tutorial
  elseif k == 'm' then
    bounceSfx:setVolume(0)
  elseif k == 'u' then
    bounceSfx:setVolume(.5)
  end
end