math.randomseed(os.time())

score = 0

x = 1

gameOver = false
pauseGame = false
tutorial = false
mainMenu = true

image = love.graphics.newImage("assets/true-jedi.png")

greenFont = {0, 1, 0, 1}
bigFont = love.graphics.newFont("assets/Stick-Regular.ttf", 100)
smallFont = love.graphics.newFont("assets/Stick-Regular.ttf", 25)
miniFont = love.graphics.newFont("assets/Stick-Regular.ttf", 15)

music = love.audio.newSource("assets/elevator.mp3", "stream")
music:setVolume(1)
bounceSfx = love.audio.newSource("assets/bounce.mp3", "static")
bounceSfx:setVolume(0.5)

load = require('load')
update = require('update')
draw = require('draw')
collision = require('collision')
keybinds = require('keybinds')