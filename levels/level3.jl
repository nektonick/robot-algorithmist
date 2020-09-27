function level3(r)
    println("level3")
    r = Robot(; animate=true)

    #движемся в левый нижний угол
    moves!(r, Down)
    moves!(r, Left)

    horisontalDirection = Right

    while(!(isborder(r, Up)))
        movesAndPutMarkers!(r, horisontalDirection)
        moves!(r, Up, 1)
        horisontalDirection = inverse(horisontalDirection)
    end
    movesAndPutMarkers!(r, horisontalDirection)
end