include("./my_lib.jl") 

mutable struct MyRobot
    robot::Robot
    x::Int
    y::Int 
    current_side::HorizonSide 
    start_border_side::HorizonSide 
    prev_border_side::HorizonSide 
    MyRobot() = new(Robot("level_maps/labyrinth.sit"; animate=true), 0, 0, Up, Up, Up)
    MyRobot(r::Robot) = new(r, 0, 0, get_start_move_side(r), get_start_border_position(r), get_start_border_position(r))

end

function getX(r::MyRobot)
    return r.x
end

function get_start_border_position(r::Robot)
    for i in (Down, Right, Up, Left)
        if (isborder(r, i))
            return i
        end
    end
    return Nothing
end

function get_start_move_side(r::Robot)
    return next_counterclockwise_side(get_start_border_position(r))
end

# полностью совпадает с get_start_border_position(r::Robot)
function get_border_side(r::MyRobot)
    for i in (Down, Right, Up, Left)
        if (isborder(r.robot, i))
            return i
        end
    end
    return Nothing
end

function move_along_border(r::MyRobot)
    if !(isborder(r.robot, r.current_side))
        move!(r.robot, r.current_side)
        if (r.current_side == Up)
            r.y+=1
        elseif (r.current_side == Down)
            r.y-=1
        elseif (r.current_side == Right)
            r.x+=1
        elseif (r.current_side == Left)
            r.x-=1 
        end
    end
    r.prev_border_side = next_clockwise_side(r.current_side)
end

"""Возвращает 1, если робот находится на "внешнем" углу, 2, если во внутреннем (т.е. рядом 2 соприкасающиеся перегородки), 0, если это не угол"""
function get_type_of_corner(r::MyRobot)
    ans = 0
    for i in (Up, Right, Down, Left)
        if (isborder(r.robot, i) && isborder(r.robot, next_counterclockwise_side(i)))
            ans =  2
        end
    end
    
    if (isborder(r.robot, r.prev_border_side) == false )
        ans = 1
    end
    return ans
end

function turn_right(r::MyRobot)
    r.current_side = HorizonSide( mod( Int(r.current_side) + 1, 4 ) )
end

function turn_left(r::MyRobot)
    r.current_side = HorizonSide( mod( Int(r.current_side) -1, 4 ) )
end
