-- Den här funktionen registerar om två objekt kolliderar, de kolliderar egentligen inte utan
-- det är avståndet mellan de objektens position som bedömer kollisionen
function checkCollission(fixture1, fixture2, distance)
  if love.physics.getDistance(fixture1,fixture2) < distance then
    return true
  end
end