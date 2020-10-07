function level8(r)
    println("level8")
    println("Робот слева или справа от перегородки? L/R")
    n = readline()
    (n == "L") ? r=Robot("levels/situation_8_1.sit"; animate=true) : r=Robot("levels/situation_8_2.sit"; animate=true)
    

    n=0; side=Left
    while isborder(r,Up)==true # прохода сверху нет
        n+=1
        moves!(r,side,n)
        side=inverse(side)
    end

end