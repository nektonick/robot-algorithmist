function level12(r)
    println("level12")
    r=Robot(; animate=true)
    println("Введите размер клтеки")
    cellOfField = parse(Int, readline())
    x=0; y=0

    num_steps, _, _ = moveToLeftDownCornerAndReturnArrayOfSteps(r)

    horisontalDirection = Right
    
    while !(isborder(r, Up) && isborder(r, Right))
        putMarkerIfNecessary(r, x, y, cellOfField)
        if isborder(r, Right) || isborder(r, Left) && !(isborder(r, Down) && isborder(r, Left))
            move!(r, Up)
            y+=1
            putMarkerIfNecessary(r, x, y, cellOfField)
            horisontalDirection = inverse(horisontalDirection)
        end

        move!(r,horisontalDirection)
        (horisontalDirection == Right) ? x+=1 : x-=1
    end

    putMarkerIfNecessary(r, x, y, cellOfField)

    moveToLeftDownCorner!(r)

    returnByStepsIn(r, num_steps)
end

function putMarkerIfNecessary(r, x, y, cellOfField)
    if(mod(x, 2*cellOfField)) < cellOfField && (mod(y, 2*cellOfField)) < cellOfField || 
        (mod(x+ cellOfField, 2*cellOfField)) < cellOfField && (mod(y, 2*cellOfField)) >= cellOfField
        putmarker!(r)
    end
end