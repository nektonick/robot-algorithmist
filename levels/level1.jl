function level1(r::Robot)
    println("level1")
    r = Robot(; animate=true)

    println("Есть ли в некоторых клетках поля маркеры? y/n")

    userAnswer = readline()

    

    if (userAnswer == "n")
        for side in (DirectionsOfMovement(i) for i=0:3)
            putmarkers!(r,side)
            move_by_markers(r, inverse(side))
        end
        putmarker!(r)
    elseif (userAnswer == "y")
        for side in (DirectionsOfMovement(i) for i=0:3)
            steps = 0
            while isborder(r,side)==false
                move!(r,side)
                if (!(ismarker(r)))
                    putmarker!(r)
                end
                steps+=1
            end
            moves!(r, inverse(side), steps)
        end
        if (!(ismarker(r)))
            putmarker!(r)
        end
    else
        println("Неверный ввод. Завершение программы.")
    end
    

end