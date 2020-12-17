function level11(r)
    println("level11")
    r=Robot("levels/situation_11.sit"; animate=true)
    
    steps, verticalPos, horizontalPos = moveToLeftDownCornerAndReturnArrayOfSteps(r)

    for side in (Up, Right, Down, Left)
        if (side == Up || side == Down)
            verticalPos = specialMove(r, verticalPos, side)
        else
            horizontalPos = specialMove(r, horizontalPos, side)
        end
    end

    returnByStepsIn(r, steps)
end

function specialMove(r, pos, side)
    while (pos>0)
        move!(r, side)
        pos -=1
    end

    putmarker!(r)

    while !isborder(r, side)
        move!(r, side)
        pos +=1
    end
    return pos
end