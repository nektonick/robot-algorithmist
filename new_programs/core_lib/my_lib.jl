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
next_counterclockwise_side(side::HorizonSide)::HorizonSide = HorizonSide(mod(Int(side)+1,4))

"""
Следующее по часовой стрелке напрвление 
"""
next_clockwise_side(side::HorizonSide)::HorizonSide= HorizonSide(mod(Int(side)-1,4))

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
Вспомогательная функция для обхода перегородки
"""
function go_to_local_border_end_and_return_steps!(r::Robot, side::HorizonSide; other_side_prioritet::Bool = false)
    left_moves = 0
    border_from_right = false
    border_from_left = false
    while isborder(r,side)
        if (isborder(r,next_clockwise_side(side))) #граница справа -> двигаемся влево
            border_from_right = true
            while left_moves < 0
                move!(r,next_counterclockwise_side(side))
                left_moves += 1
            end
        end
        if (isborder(r,next_counterclockwise_side(side))) # граница слева -> двигаемся вправо 
            border_from_left = true
            while left_moves > 0
                move!(r, next_clockwise_side(side))
                left_moves -= 1
            end
        end

        if other_side_prioritet
            if !border_from_left
                move!(r,next_counterclockwise_side(side))
                left_moves += 1
            elseif !border_from_right
                move!(r,next_clockwise_side(side))
                left_moves-=1
            else
                break
            end     
        else
            if !border_from_right
                move!(r,next_clockwise_side(side))
                left_moves-=1
            elseif !border_from_left
                move!(r,next_counterclockwise_side(side))
                left_moves += 1
            else
                break
            end  
        end

    end
    return left_moves
end

"""
Вспомогательная функция
"""
function sup_move_orthogonal!(r::Robot, side::HorizonSide, orth_side::HorizonSide, num_of_orthogonal_steps::Int)::Int
    direction_steps = 0
    while isborder(r, orth_side) && !isborder(r, side)
        move!(r,side)
        direction_steps +=1
    end
    for _ in 1:num_of_orthogonal_steps
        if !isborder(r, orth_side)
            move!(r, orth_side)
        else
            while isborder(r, orth_side) && !isborder(r, inverse_side(side))
                direction_steps -= 1
                move!(r, inverse_side(side))
            end
            move!(r, orth_side)
        end

    end
    return direction_steps
end

"""
Вспомогательная функция
"""
function sup_move_near_border_and_return_steps!(r::Robot, side::HorizonSide, num_of_orthogonal_steps::Int)::Int
    ans = 0
    if num_of_orthogonal_steps != 0
        if num_of_orthogonal_steps > 0 # робот двигался влево
            ans = sup_move_orthogonal!(r, side, next_clockwise_side(side), num_of_orthogonal_steps)
        else
            ans = sup_move_orthogonal!(r, side, next_counterclockwise_side(side), abs(num_of_orthogonal_steps))
        end           
    end
    return ans
end

"""
sup_go_pass_obstacles_and_return_number_of_steps_in_direction!(r::Robot, side::HorizonSide, markers::Bool = false)::Int

Вспомогательная функция, обходящая внутренний прямоугольник
"""
function sup_go_pass_obstacles_and_return_number_of_steps_in_direction!(r::Robot, side::HorizonSide, markers::Bool = false) ::Int
    if markers
        putmarker!(r)
    end

    num_of_orthogonal_steps = go_to_local_border_end_and_return_steps!(r, side)
    
    direction_steps = 0

    # двигаемся вверх, либо оказываемся сбоку от границы перегородки, либо прошли перегородку
    if !isborder(r,side)
        move!(r,side)
        direction_steps +=1
    end
    
    direction_steps += sup_move_near_border_and_return_steps!(r, side, num_of_orthogonal_steps)   
    
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
        sum = sup_go_pass_obstacles_and_return_number_of_steps_in_direction!(r,side, true)
        while (sum>0)
            ans += sum
            sum = sup_go_pass_obstacles_and_return_number_of_steps_in_direction!(r,side, true)
        end
    else
        ans = 0
        sum = sup_go_pass_obstacles_and_return_number_of_steps_in_direction!(r,side)
        while (sum>0)
            ans += sum
            sum = sup_go_pass_obstacles_and_return_number_of_steps_in_direction!(r,side)
        end
    end
    return ans    
end

"""
go_back_pass_obstacles!(r::Robot, side::HorizonSide, steps_to_do::Int; markers::Bool = false)

Робот идёт на steps_to_do шагов в направлении, минуя перегородки
"""
function go_back_pass_obstacles!(r::Robot, side::HorizonSide, steps_to_do::Int; markers::Bool = false, ignore_warning = false)
    steps_to_go_back = 0
    while (steps_to_do > 0)

        if markers
            putmarker!(r)
        end
    
        num_of_orthogonal_steps = go_to_local_border_end_and_return_steps!(r, side)
    
        direction_steps = 0

        # двигаемся вверх, либо оказываемся сбоку от границы перегородки, либо прошли перегородку
        if !isborder(r,side)
            move!(r,side)
            steps_to_do -= 1
            steps_to_go_back += 1
        end

        steps_done = sup_move_near_border_and_return_steps!(r, side, num_of_orthogonal_steps) 
        if (steps_done <= steps_to_do && (steps_to_go_back+abs(num_of_orthogonal_steps)) != 0) 
            steps_to_do -= steps_done
        else
            user_ans = "N"
            if !ignore_warning
                println("Робот не может попасть в данную клетку. Вернуться назад? (Y/N)")
                user_ans = readline()
            end
            if user_ans == "Y" || ignore_warning
                go_to_local_border_end_and_return_steps!(r, inverse_side(side); other_side_prioritet = true)
                if !isborder(r, inverse_side(side)) && steps_to_go_back > 0
                    while steps_to_go_back > 0
                        move!(r, inverse_side(side))
                        steps_to_go_back -= 1
                    end
                end
                sup_move_near_border_and_return_steps!(r, inverse_side(side), -num_of_orthogonal_steps)
            end
            break
        end  
    end
end

"""
go_to_left_down_corner_and_return_path!(r::Robot) ::Array

Перемещает робота в левый нижний угол и возвращет path, 
по которому можно вернуться обратно используя функцию go_by_path!(r::Robot, path::Array). 

"""
function go_to_left_down_corner_and_return_path!(r::Robot) ::Array
    path=[]
    while isborder(r,Down)==false || isborder(r,Left)==false
        if isborder(r,Down)==false
            move!(r,Down)
            push!(path,Up)
        end
        if isborder(r,Left)==false
            move!(r,Left)
            push!(path,Right)
        end
    end
    return path
end

"""
go_to_l_corner_special!(r::Robot) ::Array

Возвращет массив: сдвиг по x, сдвиг по y, ещё один сдвиг по x
"""
function go_to_l_corner_special!(r::Robot) ::Array
    path=[]
    push!(path, go_to_border_and_return_steps!(r,Left))
    push!(path, go_to_border_and_return_steps!(r,Down))
    push!(path, go_to_border_and_return_steps!(r,Left))
    return path
end

"""
go_by_path!(r::Robot, path::Array) 

Робот идёт по пути. Путь задан как массив направлений HorizonSide
"""
function go_by_path!(r::Robot, path::Array)
    n=length(path)
    while n>0
        move!(r,path[n])
        n=n-1
    end
end

"""
go_by_path!(r::Robot, path::Array) 

Робот идёт по пути. Путь задан как массив направлений HorizonSide
"""
function go_by_path_special!(r::Robot, path::Array)
    go_back_pass_obstacles!(r, Right, path[3])
    go_back_pass_obstacles!(r, Up, path[2])
    go_back_pass_obstacles!(r, Right, path[1])
end