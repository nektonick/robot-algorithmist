function level13(r)
    println("level13")
    r=Robot(; animate=true)

    for side in ((Up,Left),(Up,Right),(Down,Right),(Down,Left))
        moveAndPutMarkersDiagonal!(r,side)
        returnRobotBack!(r, side)
    end
    putmarker!(r)
end

function returnRobotBack!(r,side) 
    while (ismarker(r)) 
        move!(r, inverse(side[1]))
        move!(r, inverse(side[2]))
    end
end

function moveAndPutMarkersDiagonal!(r, side::NTuple{2,DirectionsOfMovement})
    while isborder(r,side[1]) == false  &&   isborder(r,side[2]) == false
        move!(r,side[1])
        move!(r,side[2])
        putmarker!(r)
    end
end
