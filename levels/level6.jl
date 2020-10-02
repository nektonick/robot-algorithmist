function level6(r)
    println("level6")
    r=Robot("levels/situation_6.sit")
    show(r)
    num_steps=[]

    #пока неясен алгоритм решения. сделаю потом


    #идём в левый нижний угол и сохраняем путь
    #=while isborder(r,Down)==false || isborder(r,Left)==false
        if (isborder(r, Down) == false)
            push!(num_steps, "Up")
            move!(r, Down)
        end
        if (isborder(r, Left) == false)
            push!(num_steps, "Right")
            move!(r, Left)
        end
    end



    #возвращаемся в исходную клетку
    for element in num_steps
        if (element == "Up")
            move!(r, Up)
        end
        if (element == "Right")
            move!(r, Right)
        end
    end 
    =#
end