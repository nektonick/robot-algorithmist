# Изменяю названия для сторон света, так как мне неудобно использовать немецкие
""" Северное напрвление """
Up = Nord

""" Южное напрвление """
Down = Sud

""" Западное напрвление """
Left = West

""" Восточное напрвление """
Right = Ost

# Работающая функциях сохранения карты
"""
save(sit ,file_name::AbstractString)

Функция сохранения текущей обстановки.
Пример вызова: save(r.situation, "levels/example.sit")
"""
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

"""
Следующее против часовой стрелки напрвление 
"""
next_counterclockwise_side(side::HorizonSide) = HorizonSide(mod(Int(side)+1,4))

"""
Следующее по часовой стрелке напрвление 
"""
next_clockwise_side(side::HorizonSide)= HorizonSide(mod(Int(side)-1,4))

"""
Противоположное напрвление 
"""
inverse_side(side::HorizonSide) = HorizonSide(mod(Int(side)+2, 4)) 

"""
move_for_n_steps!(r::Robot,side::HorizonSide,num_steps::Int)

Перемещает робота на n шагов в направлении
"""
function move_for_n_steps!(r::Robot,side::HorizonSide,num_steps::Int)
    for _ in 1:num_steps 
        move!(r,side)
    end
end

"""
mark_direction!(r::Robot, side::HorizonSide)

Ставить маркеры, пока не упрётся в границу в направлении
"""
function mark_direction!(r::Robot, side::HorizonSide)
    while isborder(r,side)==false
        putmarker!(r)    
        move!(r,side)
    end
    putmarker!(r)
end

"""
go_pass_obstacles_and_return_number_of_steps_in_direction!(r::Robot, side::HorizonSide, markers::Bool = false)::Int

Вспомогательная функция для обхода перегородок
"""
function go_pass_obstacles_and_return_number_of_steps_in_direction!(r::Robot, side::HorizonSide, markers::Bool = false) ::Int
    if markers
        putmarker!(r)
    end

    num_of_orthogonal_steps = 0
    is_prev_right = false
    while isborder(r,side) && (!isborder(r,next_counterclockwise_side(side)) || !isborder(r,next_clockwise_side(side)))
        if !isborder(r,next_counterclockwise_side(side)) && (isborder(r,next_clockwise_side(side)) && !is_prev_right)
            move!(r,next_counterclockwise_side(side))
            num_of_orthogonal_steps += 1
            is_prev_right = true
        else
            move!(r,next_clockwise_side(side))
            num_of_orthogonal_steps -= 1
            if is_prev_right
                break
            end
        end
    end
    direction_steps = 0

    if !isborder(r,side)
        move!(r,side)
        direction_steps +=1
    end

    if num_of_orthogonal_steps != 0
        if num_of_orthogonal_steps >0
            while isborder(r, inverse_side(next_counterclockwise_side(side)))
                move!(r,side)
                direction_steps +=1
            end
            for _ in 1:num_of_orthogonal_steps
                move!(r, inverse_side(next_counterclockwise_side(side)))
            end
        else
            num_of_orthogonal_steps = abs(num_of_orthogonal_steps)
            while isborder(r, inverse_side(next_clockwise_side(side)))
                move!(r,side)
                direction_steps +=1
            end
            for _ in 1:num_of_orthogonal_steps
                move!(r, inverse_side(next_clockwise_side(side)))
            end
        end           
    end
    
    return direction_steps 
end

"""
go_to_border_and_return_steps!(r::Robot,side::HorizonSide; markers::Bool = false)

Робот доходит до непреодолимой перегородки в данном направлении и возвращает количество шагов в ЭТОМ направлении 
Параметр markers отвечает за то, надо ли ставить по пути маркеры
"""
function go_to_border_and_return_steps!(r::Robot,side::HorizonSide; markers::Bool = false)
    if (markers)
        ans = 0
        sum = go_pass_obstacles_and_return_number_of_steps_in_direction!(r,side, true)
        while (sum>0)
            ans += sum
            sum = go_pass_obstacles_and_return_number_of_steps_in_direction!(r,side, true)
        end
    else
        ans = 0
        sum = go_pass_obstacles_and_return_number_of_steps_in_direction!(r,side)
        while (sum>0)
            ans += sum
            sum = go_pass_obstacles_and_return_number_of_steps_in_direction!(r,side)
        end
    end
    return ans    
end

"""
go_back_pass_obstacles!(r::Robot, side::HorizonSide, steps_to_do::Int; markers::Bool = false)

Робот идёт на steps_to_do шагов в направлении, минуя перегородки
Если попасть в клетку через steps_to_do шагов в данном направлении нельзя, робот врежется в перегородку
"""
function go_back_pass_obstacles!(r::Robot, side::HorizonSide, steps_to_do::Int; markers::Bool = false)
    while (steps_to_do > 0)

        if markers
            putmarker!(r)
        end
    
        num_of_orthogonal_steps = 0
        is_prev_right = false
        while isborder(r,side) && (!isborder(r,next_counterclockwise_side(side)) || !isborder(r,next_clockwise_side(side)))
            if !isborder(r,next_counterclockwise_side(side))
                move!(r,next_counterclockwise_side(side))
                num_of_orthogonal_steps += 1
                is_prev_right = true
            else
                move!(r,next_clockwise_side(side))
                num_of_orthogonal_steps -= 1
                if is_prev_right
                    break
                end
            end
        end
    
        if !isborder(r,side) && steps_to_do > 0
            move!(r,side)
            steps_to_do -= 1
        end
    
        if num_of_orthogonal_steps != 0
            if num_of_orthogonal_steps >0
                while isborder(r, inverse_side(next_counterclockwise_side(side)))
                    move!(r,side)
                    steps_to_do -= 1
                end
                for _ in 1:num_of_orthogonal_steps
                    move!(r, inverse_side(next_counterclockwise_side(side)))
                end
            else
                num_of_orthogonal_steps = abs(num_of_orthogonal_steps)
                while isborder(r, inverse_side(next_clockwise_side(side)))
                    move!(r,side)
                    steps_to_do -= 1
                end
                for _ in 1:num_of_orthogonal_steps
                    move!(r, inverse_side(next_clockwise_side(side)))
                end
            end           
        end
    end
end

function mark_direction_with_borders!(r::Robot, side::HorizonSide)
    go_to_border_and_return_steps!(r, side; markers = true)
    putmarker!(r)
end