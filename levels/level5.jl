function level5(r)
    println("level5")
    r = Robot("levels/situation_5.sit"; animate=true)

    num_steps=[]
    while isborder(r,Down)==false || isborder(r,Left)==false
        if (isborder(r, Down) == false)
            push!(num_steps, "Up")
            move!(r, Down)
        end
        if (isborder(r, Left) == false)
            push!(num_steps, "Right")
            move!(r, Left)
        end
    end

    for side in (Up, Right, Down, Left)
        moves!(r,side)
        putmarker!(r)
    end

    for element in reverse(num_steps)
        if (element == "Up")
            move!(r, Up)
        end
        if (element == "Right")
            move!(r, Right)
        end
    end        
end

#Другое решение, которое я не вполне понимаю
function level5__(r)
    println("level5")
    r = Robot("levels/situation_5.sit"; animate=true)

    num_steps=[]
    #Пока можем, двигаемся в нижний угол, сохраняя шаги в массив
    while isborder(r,Down)==false || isborder(r,Left)==false
        push!(num_steps,moves!(r,Left))
        push!(num_steps,moves!(r,Down))
    end

    #ставим маркеры по всем углам
    for side in (Up, Right, Down, Left)
        moves!(r,side)
        putmarker!(r)
    end

   
    k=length(num_steps)
    i = (mod(k, 2) == 1) ? 2 : 1
    #возвращаемся в исходную клетку
    for n in (1:k)
        i=i+1
        t=isodd(i)
        side=Up
        if (t == true)
            side = Right
        end
        moves!(r,side,num_steps[k-n+1])
    end 
end