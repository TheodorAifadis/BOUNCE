-- funktion för att registrera kollision
-- om avståndet mellan två bestämda föremål är mindre än ett bestämt avstånd så "kolliderar" dessa
function checkCollission(fixture1, fixture2, distance)
  if love.physics.getDistance(fixture1,fixture2) < distance then
    return true
  end
end