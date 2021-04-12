function loadHighScore() -- funktion som laddar highscore
    
    highscore = love.filesystem.read("data.sav") -- highscore sparas i data.sav som ett värde

    if(highscore == nil)then -- det börjar med nil för att det från början inte har ett värde
        highscore = 0
    end

    return highscore

end

function saveHighScore(newHighScore) -- highscore sparas och om man slår det så sparas det nya highscore

    love.filesystem.write("data.sav", newHighScore) -- highscore byts ut mot det nya värdet

end