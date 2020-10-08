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

    while (verticalPos>0)
        move!(r, Up)
        verticalPos -=1
    end

    putmarker!(r)

    while !isborder(r, Up)
        move!(r, Up)
        verticalPos +=1
    end

    while (horizontalPos>0)
        move!(r, Right)
        horizontalPos -=1
    end

    putmarker!(r)

    while !isborder(r, Right)
        move!(r, Right)
        horizontalPos +=1
    end

    while (verticalPos>0)
        move!(r, Down)
        verticalPos -=1
    end

    putmarker!(r)

    while !isborder(r, Down)
        move!(r, Down)
        verticalPos +=1
    end

    while (horizontalPos>0)
        move!(r, Left)
        horizontalPos -=1
    end

    putmarker!(r)

    while !isborder(r, Left)
        move!(r, Left)
        horizontalPos +=1
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
