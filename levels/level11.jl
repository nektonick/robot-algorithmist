function level11(r)
    println("level11")
    r=Robot("levels/situation_11.sit"; animate=true)
    verticalPos = 0
    horizontalPos = 0
    num_steps=[]
    #в левый нижний угол
    while (isborder(r,Down)==false || isborder(r,Left)==false)
        if (isborder(r, Down) == false)
            push!(num_steps, "Up")
            verticalPos+=1
            move!(r, Down)
        end
        if (isborder(r, Left) == false)
            push!(num_steps, "Right")
            horizontalPos+=1
            move!(r, Left)
        end
    end


    for side in (Up, Right, Down, Left)
        if (side == Up || side == Down)
            verticalPos = specialMove(r, verticalPos, side)
        else
            horizontalPos = specialMove(r, horizontalPos, side)
        end
    end

    #в исходное положение
    for element in reverse(num_steps)
        if (element == "Up")
            move!(r, Up)
        elseif (element == "Right")
            move!(r, Right)
        end
    end

end

function specialMove(r, pos, side )
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