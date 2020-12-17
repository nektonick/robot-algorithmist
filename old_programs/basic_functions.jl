function putmarkers!(r::Robot, side::DirectionsOfMovement)
    while isborder(r,side)==false
        move!(r,side)
        putmarker!(r)
    end
end

inverse(side::DirectionsOfMovement) = DirectionsOfMovement(mod(Int(side)+2, 4)) 

move_by_markers(r::Robot,side::DirectionsOfMovement) = while ismarker(r)==true 
    move!(r,side) 
end

function moves!(r::Robot,side::DirectionsOfMovement)
    num_steps=0
    while isborder(r,side)==false
        move!(r,side)
        num_steps+=1
    end
    return num_steps
end

function moves!(r::Robot,side::DirectionsOfMovement,num_steps::Int)
    for _ in 1:num_steps # символ "_" заменяет фактически не используемую переменную
        move!(r,side)
    end
end

function movesAndPutMarkers!(r::Robot,side::DirectionsOfMovement)
    while isborder(r, side) == false
        putmarker!(r)
        move!(r,side)
    end
    putmarker!(r)
end

function movesAndPutMarkers!(r::Robot,side::DirectionsOfMovement, countOfMarkers::Int)
    while isborder(r, side) == false
        if (countOfMarkers > 0)
            putmarker!(r)
            countOfMarkers = countOfMarkers - 1
        end
        move!(r,side)
    end
    if (countOfMarkers > 0)
        putmarker!(r)
    end
end

function moveToLeftDownCorner!(r::Robot)
    moves!(r, Down)
    moves!(r, Left)
end

function moveToLeftDownCornerAndReturnArrayOfSteps(r)
    num_steps=[]
    verticalPos = 0
    horizontalPos = 0
    while (isborder(r,Down)==false || isborder(r,Left)==false)
        if (isborder(r, Down) == false)
            push!(num_steps, "Up")
            verticalPos+=1
            move!(r, Down)
        end
        if (isborder(r, Left) == false)
            push!(num_steps, "Right")
            horizontalPos+=1
            move!(r, Left)
        end
    end
    return num_steps, verticalPos, horizontalPos
end

function returnByStepsIn(r, num_steps)
    for element in reverse(num_steps)
        if (element == "Up")
            move!(r, Up)
        elseif (element == "Right")
            move!(r, Right)
        end
    end
end

nextDirection(side::DirectionsOfMovement)=DirectionsOfMovement(mod(Int(side)+1,4))
prevDirection(side::DirectionsOfMovement)=DirectionsOfMovement(mod(Int(side)-1,4))

function moveWhilePossible!(r, side)
    nextSide = nextDirection(side)
    prevSide = prevDirection(side)
    num_steps=0
    while isborder(r, side) == true
        if isborder(r, nextSide) == false
            move!(r, nextSide)
            num_steps += 1
        else
            break
        end
    end
    
    if isborder(r,side) == false
        while isborder(r, nextSide) == true
            move!(r,side)
        end
        result = true
    else
        result = false
    end
    move!(r, prevSide)
    return result
end

function putmarkes!(r,side)
    num_steps=0 
    while moveWhilePossible!(r, side) == true
        if !ismarker(r) 
            putmarker!(r)
        end
        num_steps += 1
    end 
    return num_steps
end

moveWithManeuvers!(r, side, num_steps) =
for _ in 1:num_steps
    moveWhilePossible!(r,side)
end