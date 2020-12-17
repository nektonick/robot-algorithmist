function level6(r)
    println("level6")
    r=Robot("levels/situation_6.sit"; animate=true)
    num_steps, _, _ =moveToLeftDownCornerAndReturnArrayOfSteps(r)

    #обходим поле змейкой (вверх-вниз), пока справа не будет стенки
    isDirUp = true
    move!(r, Up)
    while !isborder(r, Right)
        if !isborder(r, Up) && !isborder(r, Down)
            (isDirUp == true) ? move!(r, Up) : move!(r, Down)
        else
            move!(r, Right)
            isborder(r, Up) ? move!(r, Down) : move!(r, Up)
            isDirUp = !isDirUp
        end
    end

    #Обходим фигуру покругу
    for dir in (Up, Right, Down, Left)
        while isborder(r, DirectionsOfMovement(mod(Int(dir)-1, 4))) && !(ismarker(r))
            putmarker!(r)
            move!(r, dir)
        end
        if !(ismarker(r))
            putmarker!(r)
            move!(r, DirectionsOfMovement(mod(Int(dir)-1, 4)))
        end
    end 

    moveToLeftDownCorner!(r)

    returnByStepsIn(r, num_steps)
    
end