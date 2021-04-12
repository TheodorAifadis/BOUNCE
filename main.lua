math.randomseed(os.time())

highscore = 0
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

music = love.audio.newSource("assets/bensound-house.mp3", "stream")
music:setVolume(1)
music:setLooping(true)

require('load')
require('update')
require('draw')
require('collision')
require('keybinds')
require('highscore')