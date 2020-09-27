function level4(r)
    println("level4")
    r = Robot(5, 5; animate=true)

    #движемся в левый нижний угол
    nDown = moves!(r, Down)
    nLeft = moves!(r, Left)

    #Мереем ширину поля и возвращаемся
    horizontalSize = moves!(r, Right)
    moves!(r, Left)
    horizontalSize = horizontalSize + 1

    while(!(isborder(r, Up)))
        movesAndPutMarkers!(r, Right, horizontalSize)
        horizontalSize = horizontalSize - 1
        if (horizontalSize < 0)
            horizontalSize = 0
        end
        moves!(r,Left)
        moves!(r, Up, 1)
    end
    movesAndPutMarkers!(r, Right, horizontalSize)
    
    #возвращение в левый нижний угол
    moveToLeftDownCorner!(r)
    #возвращение в начальное положение
    moves!(r, Up, nDown)
    moves!(r, Right, nLeft)
end