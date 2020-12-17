function level2(r)
    println("level2")
    r = Robot(; animate=true)
    #движемся в левый нижний угол
    num_vert = moves!(r, Down)
    num_hor = moves!(r, Left)
    #ставим маркеры по кругу
    for dir in (Up, Right, Down, Left)
        putmarkers!(r, dir)
    end 
    #возвращаемся в исходную точку
    moves!(r, Up, num_vert)
    moves!(r, Right, num_hor)
end