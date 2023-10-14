local tX = 200
local tS = 5

function next()
    nextLevel()
end

function transitionTo(nextFunc)
    tS = 5
    next = nextFunc
end

function updateTransition()
    if tX >= 230 then
        next()
        tS = -5
        tX = 225
    end
    if tS ~= 0 and tX >= 0 then
        tX += tS
    elseif tX <= 0 then
        tX = 0
        tS = 0
    end

    playdate.graphics.fillRect(0,0,tX,160)
end

function sign(number)
    return (number > 0 and 1) or (number == 0 and 0) or -1
end