function level3(r)
    println("level3")
    r = Robot(4, 4; animate=true)

    #движемся в левый нижний угол
    steps, _, _ = moveToLeftDownCornerAndReturnArrayOfSteps(r)

    horisontalDirection = Right

    while(!(isborder(r, Up)))
        movesAndPutMarkers!(r, horisontalDirection)
        moves!(r, Up, 1)
        horisontalDirection = inverse(horisontalDirection)
    end
    movesAndPutMarkers!(r, horisontalDirection)
    
    #возвращение в левый нижний угол
    moveToLeftDownCorner!(r)
    #возвращение в начальное положение
    returnByStepsIn(r, steps)
end