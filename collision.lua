function checkCollission(fixture1, fixture2, distance)
  if love.physics.getDistance(fixture1,fixture2) < distance then
    return true
  end
end