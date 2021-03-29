local world = require('world')

player = {}
  player.body = love.physics.newBody(world, 650/2, 650/2, "dynamic")
  player.shape = love.physics.newCircleShape(20) -- radius
  player.fixture = love.physics.newFixture(player.body, player.shape, 1) -- density
  player.fixture:setRestitution(1) -- bounce

return player