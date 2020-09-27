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