# Изменяю названия для сторон света, так как мне неудобно использовать немецкие
Up = Nord
Down = Sud
Left = West
Right = Ost

# Работающая функциях сохранения карты
function save(sit ,file_name::AbstractString)
    open(file_name,"w") do io
        write(io, "frame_size:\n") # 11 12
        write(io, join(sit.frame_size, " "),"\n")
        write(io, "coefficient:\n")
        write(io, join(sit.coefficient),"\n")
        write(io, "is_framed:\n") # "true"
        write(io, join(sit.is_framed), "\n")
        write(io, "robot_position:\n") # 1 1
        write(io, join(sit.robot_position, " "), "\n")
        write(io, "temperature_map:\n") # 1 2 3 1 2
        write(io, join(sit.temperature_map, " "), "\n")
        write(io, "markers_map:\n") # "(1, 2)(3, 2)(4, 5)"
        write(io, join(sit.markers_map), "\n")
        write(io,"borders_map:\n")
        for set_positions ∈ sit.borders_map # set_positions - множество запрещенных направлений
            write(io, join(Int.(set_positions)," "), "\n")   # 0 1 3
        end
    end 
    println("Сохранение завершено")
end 

next_side(side::HorizonSide)= HorizonSide(mod(Int(side)+1,4))
prev_side(side::HorizonSide)= HorizonSide(mod(Int(side)-1,4))
inverse_side(side::HorizonSide) = HorizonSide(mod(Int(side)+2, 4)) 

function moves!(r::Robot,side::HorizonSide,num_steps::Int)
    for _ in 1:num_steps 
        move!(r,side)
    end
end

function move_if_possible!(r::Robot, direct_side::HorizonSide)::Bool
    left_side = next_side(direct_side)
    right_side = inverse_side(left_side)
    num_of_steps=0

    if isborder(r,direct_side)==false
        move!(r,direct_side)
        result=true
    else
        while isborder(r,direct_side) == true
            if isborder(r, left_side) == false
                move!(r, left_side)
                num_of_steps += 1
            else
                break
            end
        end
        if isborder(r,direct_side) == false
            move!(r,direct_side)
            while isborder(r,right_side) == true
                move!(r,direct_side)
            end
            result = true
        else
            result = false
        end
        while num_of_steps>0
            num_of_steps=num_of_steps-1
            move!(r,right_side)
        end
    end
    return result
end