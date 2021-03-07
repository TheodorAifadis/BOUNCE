function love.load()
  love.physics.setMeter(64)
  world = love.physics.newWorld(0, 9.82*64, true)

--[[
  local begin_contact_callback = function (fixture_a, fixture_b, contact)
    local objects_a = fixture_a:getUserData()
    local objects_b = fixture_b:getUserData()
    if objects_a.begin_contact then objects_a:begin_contact() end
    if objects_b.begin_contact then objects_b:begin_contact() end
  end

  
  world:setCallbacks(
    begin_contact_callback,
    nil,
    nil,
    nil
  )
--]]
 
  objects = {}  

  objects.ground = {}
  objects.ground.body = love.physics.newBody(world, 650/2, 650-50/2)
  objects.ground.shape = love.physics.newRectangleShape(650, 50)
  objects.ground.fixture = love.physics.newFixture(objects.ground.body, objects.ground.shape)

  objects.leftWall = {}
  objects.leftWall.body = love.physics.newBody(world, 1, 650-50/2)
  objects.leftWall.shape = love.physics.newRectangleShape(50, 1300)
  objects.leftWall.fixture = love.physics.newFixture(objects.leftWall.body, objects.leftWall.shape)

  objects.rightWall = {}
  objects.rightWall.body = love.physics.newBody(world, 649, 650-50/2)
  objects.rightWall.shape = love.physics.newRectangleShape(50, 1300)
  objects.rightWall.fixture = love.physics.newFixture(objects.rightWall.body, objects.rightWall.shape)

  objects.ball = {}
  objects.ball.body = love.physics.newBody(world, 650/2, 650/2, "dynamic")
  objects.ball.shape = love.physics.newCircleShape(20) -- radie
  objects.ball.fixture = love.physics.newFixture(objects.ball.body, objects.ball.shape, 1) -- densitet
  objects.ball.fixture:setRestitution(1) -- studskoefficient

  objects.triangle = {}
  objects.triangle.body = love.physics.newBody(world, 300, 0, "dynamic")
  objects.triangle.shape = love.physics.newPolygonShape(30, 30, 90, 30, 30, 90)
  objects.triangle.fixture = love.physics.newFixture(objects.triangle.body, objects.triangle.shape, 1)
 --[[
  objects.triangle.begin_contact = function (self)
    objects.triangle.fixture:destroy()
  end
--]]

  love.graphics.setBackgroundColor(0, 0, 0)
  love.window.setMode(650, 650)
end

function love.update(dt)
  world:update(dt)

  if love.keyboard.isDown("right") then 
    objects.ball.body:applyForce(400, 0)
  elseif love.keyboard.isDown("left") then 
    objects.ball.body:applyForce(-400, 0)
  end

function love.keypressed(k)
  if k == 'escape' then
    love.event.quit()
  end
end

end

function love.draw()
  love.graphics.setColor(.1, 0, 0)
  love.graphics.polygon("fill", objects.leftWall.body:getWorldPoints(objects.leftWall.shape:getPoints()))

  love.graphics.setColor(.1, 0, 0)
  love.graphics.polygon("fill", objects.rightWall.body:getWorldPoints(objects.rightWall.shape:getPoints()))
  
  love.graphics.setColor(0, .1, 0)
  love.graphics.polygon("fill", objects.ground.body:getWorldPoints(objects.ground.shape:getPoints()))

  love.graphics.setColor(1, 0, 0)
  love.graphics.polygon("fill", objects.triangle.body:getWorldPoints(objects.triangle.shape:getPoints()))

  love.graphics.setColor(1, 1, 1)
  love.graphics.circle("fill", objects.ball.body:getX(), objects.ball.body:getY(), objects.ball.shape:getRadius())
end