function love.load()
    -- Det här sätter 1 meter till 64 pixlar
    love.physics.setMeter(64)
    -- Det här ger "världen" gravitation, 9.82*64 är tyngkraften multiplicerat med 1 meter i pixlar
    world = love.physics.newWorld(0, 9.82*64, true)

  -- Table som kommer innehålla alla fysiska objekt
    objects = {}

  -- Det här skapar en plattform/marken
    objects.ground = {}
  -- Marken är en rektangel som utgår från centrum vilket gör att jag tar 450/2, 450-50/2 för att få den längre ner
    objects.ground.body = love.physics.newBody(world, 450/2, 450-50/2)
  -- Här skapas en rektangel med bredden 1000 och höjden 10 (px)
    objects.ground.shape = love.physics.newRectangleShape(1000, 10)
  -- Det här sätter ihop rektangeln med bodyn
    objects.ground.fixture = love.physics.newFixture(objects.ground.body,objects.ground.shape)

  -- Här skapas en boll
  objects.ball = {}
  -- Detta placerar bollen i centrum
  objects.ball.body = love.physics.newBody(world, 650/2, 450/2, "dynamic")
  -- Boll med radien 20px
  objects.ball.shape = love.physics.newCircleShape(20)
  -- Det här lägger till i bodyn och 1 på slutet ger den bollen densiteten 1
  objects.ball.fixture = love.physics.newFixture(objects.ball.body,objects.ball.shape, 1)

  -- Gör bakgrunden vit
  love.graphics.setBackgroundColor(1, 1, 1)
  -- Det här bestämmer love-fönstrets dimensioner
  love.window.setMode(650, 650)
end

function love.update(dt)
    -- Det här ger världen dess rörelse
    world:update(dt)
end
   
  function love.draw()
    -- Gör plattformen svart
    love.graphics.setColor(0, 0, 0)
    -- Det här ritar polygonen som är marken
    love.graphics.polygon("fill", objects.ground.body:getWorldPoints(objects.ground.shape:getPoints()))
   
    -- Gör bollen grön
    love.graphics.setColor(0, 0.3, 0.4)
    love.graphics.circle("fill", objects.ball.body:getX(),objects.ball.body:getY(), objects.ball.shape:getRadius())
end