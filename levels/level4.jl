function level4(r)
    println("level4")
    r = Robot(5, 5; animate=true)

    #движемся в левый нижний угол
    nDown = moves!(r, Down)
    nLeft = moves!(r, Left)

    horisontalDirection = Right

    while(!(isborder(r, Up)))
        movesAndPutMarkers!(r, horisontalDirection)
        moves!(r, Up, 1)
        horisontalDirection = inverse(horisontalDirection)
    end
    movesAndPutMarkers!(r, horisontalDirection)
    
    #возвращение в левый нижний угол
    moves!(r, Down)
    moves!(r, Left)
    #возвращение в начальное положение
    moves!(r, Up, nDown)
    moves!(r, Right, nLeft)
end