function love.load()
  -- En meter i spelvärlden är 64 pixlar
  love.physics.setMeter(64)
  -- Det här ger världen en allmän gravitation som endast verkar på det vertikala planet med 9.82
  world = love.physics.newWorld(0, 9.82*64, true)
 
  objects = {} -- Här skapar jag en table där att fysiska kroppar kommer finnas
 
  -- Skapar marken som är en rektangel som placeras centralt långt ner på skärmen
  objects.ground = {}
  objects.ground.body = love.physics.newBody(world, 650/2, 650-50/2)
  objects.ground.shape = love.physics.newRectangleShape(650, 50)
  objects.ground.fixture = love.physics.newFixture(objects.ground.body, objects.ground.shape)

  objects.leftWall = {}
  objects.leftWall.body = love.physics.newBody(world, 0, 650-50/2)
  objects.leftWall.shape = love.physics.newRectangleShape(1, 650)
  objects.leftWall.fixture = love.physics.newFixture(objects.leftWall.body, objects.leftWall.shape)

  objects.rightWall = {}
  objects.rightWall.body = love.physics.newBody(world, 650, 650-50/2)
  objects.rightWall.shape = love.physics.newRectangleShape(1, 650)
  objects.rightWall.fixture = love.physics.newFixture(objects.rightWall.body, objects.rightWall.shape)
 
  -- Här skapas en boll som utgår från mitten av skärmen, den är dynamisk och följer fysikaliska lagar
  -- (den följer gravitationen och kan kollidera med andra objekt och marken)
  objects.ball = {}
  objects.ball.body = love.physics.newBody(world, 650/2, 650/2, "dynamic")
  objects.ball.shape = love.physics.newCircleShape(20) -- radie
  objects.ball.fixture = love.physics.newFixture(objects.ball.body, objects.ball.shape, 1) -- densitet
  objects.ball.fixture:setRestitution(1) -- det här gör att bollen studsar (allt under 1 gör att höjden avtar)

  -- Här ställer jag in bakgrundsfärg och LOVE2D-fönstrets storlek
  love.graphics.setBackgroundColor(0.7, 0.7, 1)
  love.window.setMode(650, 650)
end

function love.update(dt)
  world:update(dt)

  -- Här skapas tangentbords event
  if love.keyboard.isDown("right") then -- Pil höger, bollen flyttas höger
    objects.ball.body:applyForce(400, 0)
  elseif love.keyboard.isDown("left") then -- Pil vänster, bollen flyttas vänster
    objects.ball.body:applyForce(-400, 0)
  elseif love.keyboard.isDown("space") then -- Mellanslag, bollen återställs från centrum
    objects.ball.body:setPosition(650/2, 650/2)
    objects.ball.body:setLinearVelocity(0, 0) -- Det här sätter ursprungshastigheten till 0 för att motverka
                                              -- en alldeles för stor förändring i kraft i riktningsbyte
  end
end
 
function love.draw()
  -- Gör marken grön
  love.graphics.setColor(.2, 0.3, 0)
  love.graphics.polygon("fill", objects.ground.body:getWorldPoints(objects.ground.shape:getPoints()))
  
  -- Gör bollen röd
  love.graphics.setColor(0.8, 0, 0.2)
  love.graphics.circle("fill", objects.ball.body:getX(), objects.ball.body:getY(), objects.ball.shape:getRadius())
end