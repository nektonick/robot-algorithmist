function level7(r)
    println("level7")
    r=Robot(5, 4; animate=true)
    num_steps=[]
    isMarkerNow = true

    num_steps, x, y= moveToLeftDownCornerAndReturnArrayOfSteps(r)
    isMarkerNow = !(isodd(x+y))

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

    returnByStepsIn(r, num_steps)

end