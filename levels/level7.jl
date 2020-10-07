function level7(r)
    println("level7")
    r=Robot(5, 4; animate=true)
    num_steps=[]
    isMarkerNow = true

    #идём в левый нижний угол, не забывая про чётность
    while (isborder(r,Down)==false || isborder(r,Left)==false)
        if (isborder(r, Down) == false)
            push!(num_steps, "Up")
            move!(r, Down)
            isMarkerNow = !isMarkerNow
        end
        if (isborder(r, Left) == false)
            push!(num_steps, "Right")
            move!(r, Left)
            isMarkerNow = !isMarkerNow
        end
    end

    #идём змейкой до верхнего правого угла и ставим маркеры
    horisontalDirection = Right

    while !(isborder(r, Up) && isborder(r, Right))
        if (isMarkerNow)
            putmarker!(r)
        end
        
        if isborder(r, Right) || isborder(r, Left) && !(isborder(r, Down) && isborder(r, Left))
            move!(r, Up)
            isMarkerNow = !isMarkerNow
            if (isMarkerNow)
                putmarker!(r)
            end
            horisontalDirection = inverse(horisontalDirection)
        end

        move!(r,horisontalDirection)
        isMarkerNow = !isMarkerNow  
    end
    
    if isMarkerNow
        putmarker!(r)
    end

    moveToLeftDownCorner!(r)

    for element in reverse(num_steps)
        if (element == "Up")
            move!(r, Up)
        elseif (element == "Right")
            move!(r, Right)
        end
    end

end