include("core_lib/HorizonSideRobots.jl")
using .HorizonSideRobots

include("core_lib/labyrinth_lib.jl")

function solve()
    r = MyRobot(Robot("level_maps/labyrinth.sit"; animate=true))
    coords_array = []
    r.start_border_side = get_start_border_position(r.robot)
    r.current_side = get_start_move_side(r.robot)
    putmarker!(r.robot)
    start = true
    while !( r.x == 0 && r.y==0 &&  
        get_border_side(r) == r.start_border_side && 
        start == false)
        
        move_along_border(r)
        corner_type = get_type_of_corner(r)
        if (corner_type != 0 )
            if (r.x != 0 || r.y != 0)
                start = false
            end
            if (corner_type == 2)
                if (r.current_side == Left && isborder(r.robot, Left) && isborder(r.robot, Up) )
                    push!(coords_array, (r.x, r.y+1  ) );
                    print("Вершина с координатами: ")
                    println(coords_array[length(coords_array)])
                elseif (r.current_side == Up && isborder(r.robot, Up) && isborder(r.robot, Right) )
                    push!(coords_array, (r.x+1 , r.y+1  ) );
                    print("Вершина с координатами: ")
                    println(coords_array[length(coords_array)])
                elseif (r.current_side == Right && isborder(r.robot, Right) && isborder(r.robot, Down) )
                    push!(coords_array, (r.x+1 , r.y  ) );
                    print("Вершина с координатами: ")
                    println(coords_array[length(coords_array)])
                elseif (r.current_side == Down && isborder(r.robot, Down) && isborder(r.robot, Left) )
                    push!(coords_array, (r.x, r.y) );
                    print("Вершина с координатами: ")
                    println(coords_array[length(coords_array)])
                end
                turn_right(r)
                
            end
            if (corner_type == 1)
                if (length(coords_array) < 1 || (r.x, r.y) != coords_array[length(coords_array)])
                    if (r.prev_border_side == Left)
                        push!(coords_array, (r.x, r.y+1  ) );
                        print("Вершина с координатами: ")
                        println(coords_array[length(coords_array)])
                    elseif (r.prev_border_side == Up)
                        push!(coords_array, (r.x+1 , r.y+1  ) );
                        print("Вершина с координатами: ")
                        println(coords_array[length(coords_array)])
                    elseif (r.prev_border_side == Right)
                        push!(coords_array, (r.x+1 , r.y  ) );
                        print("Вершина с координатами: ")
                        println(coords_array[length(coords_array)])
                    elseif (r.prev_border_side == Down)
                        push!(coords_array, (r.x, r.y) );
                        print("Вершина с координатами: ")
                        println(coords_array[length(coords_array)])
                    end
                end
                turn_left(r)
            end
        end
    end #while

    s = 0.0::Float64
    for i in eachindex(coords_array)
        if (i != length(coords_array) )
            temp = coords_array[i]
            temp2 = coords_array[i+1]
            
            s += (temp[1] * temp2[2] - temp[2] * temp2[1]);
        else
            temp = coords_array[i]
            temp2 = coords_array[1]
            
            s += (temp[1] * temp2[2] - temp[2] * temp2[1]);
        end
    end
    s = s/2.0
    println("Ответ: " * string(abs(s)))
    
end

solve()

println("Спасибо за внимание!. Нажмите enter")
_ = readline()