function LOAD_HIGHSCORE() 

    local highscore = love.filesystem.read("highscore.sav")

    if(highscore == nil) then
        highscore = 0
    end

    return highscore
end

function SAVE_HIGHSCORE(newHighScore)
    love.filesystem.write("highscore.sav", newHighScore)
end