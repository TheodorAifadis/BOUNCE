function loadHighScore()
    
    local highscore = love.filesystem.read("data.sav")

    if(highscore == nil)then
        highscore = 0
    end

    return highscore

end

function saveHighScore(newHighScore)

    love.filesystem.write("data.sav", newHighScore)

end