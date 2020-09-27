function level1(r::Robot)
    println("level1")
    r = Robot(; animate=true)

    for side in (DirectionsOfMovement(i) for i=0:3) # - перебор всех возможных направлений
        putmarkers!(r,side)
        move_by_markers(r, inverse(side))
    end
    putmarker!(r)
end