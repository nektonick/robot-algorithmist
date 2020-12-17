function level10(r)
    println("level10")
    r=Robot("levels/situation_10.sit"; animate=true)

    countOfElements = 0
    sumOfElements = 0
    horisontalDirection = Right
    while !(isborder(r, Up) && isborder(r, Right))
        countOfElements += Int(ismarker(r))
        sumOfElements += getTeperatureIfMarkedElseGitZero(r)
        
        if isborder(r, Right) || isborder(r, Left) && !(isborder(r, Down) && isborder(r, Left))
            move!(r, Up)
            horisontalDirection = inverse(horisontalDirection)
        end

        move!(r,horisontalDirection) 
    end
    println(sumOfElements/countOfElements)
end

function getTeperatureIfMarkedElseGitZero(r)
    if ismarker(r)
        return temperature(r)
    else return 0
    end
end