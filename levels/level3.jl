function level3(r)
    println("level3")
    r = Robot(; animate=true)

    #движемся в левый нижний угол
    moves!(r, Down)
    moves!(r, Left)

    
end