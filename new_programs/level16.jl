include("core_lib/HorizonSideRobots.jl")
using .HorizonSideRobots
include("core_lib/my_lib.jl") 

r=Robot("level_maps/situation_16.sit"; animate=true)

function mark_everything_on_field_with_borders!(r::Robot)

    # так как в моей карте уровня есть перегородки у стен, обычная функция go_to_left_down_corner_and_return_path! не подойдёт
    # поскольку не работает корректно для случая перегородок у стен
    start_x = go_to_border_and_return_steps!(r,Left)
    start_y = go_to_border_and_return_steps!(r, Down)
    # по причине этих же перегородок у стен, нужна следующая команда. Мы проверяем, точно ли нельзя пройти ещё левее.
    additional_x = go_to_border_and_return_steps!(r,Left)

    x = go_to_border_and_return_steps!(r, Right)
    go_back_pass_obstacles!(r, Left, x)

    while x > 0
        y = go_to_border_and_return_steps!(r, Up; markers = true)
        go_back_pass_obstacles!(r, Down, y)
        x -= sup_go_pass_obstacles_and_return_number_of_steps_in_direction!(r, Right)
    end
    y = go_to_border_and_return_steps!(r, Up; markers = true)
    go_back_pass_obstacles!(r, Down, y)


    # возвращаемся в левый нижний угол
    go_to_border_and_return_steps!(r,Left)
    go_to_border_and_return_steps!(r, Down)
    go_to_border_and_return_steps!(r,Left)

    # идём в исходную точку
    go_back_pass_obstacles!(r, Right, additional_x)
    go_back_pass_obstacles!(r, Up, start_y)
    go_back_pass_obstacles!(r, Right, start_x)
end


mark_everything_on_field_with_borders!(r)

# костыль, чтобы программа сразу же не закрылась и можно было посмотреть результат её работы
println("Спасибо за внимание!. Нажмите enter")
_ = readline()