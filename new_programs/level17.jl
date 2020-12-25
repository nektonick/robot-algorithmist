include("core_lib/HorizonSideRobots.jl")
using .HorizonSideRobots
include("core_lib/my_lib.jl") 

r=Robot("level_maps/situation_17.sit"; animate=true)

function mark_bordered_field_by_stairs!(r::Robot)
    path = go_to_l_corner_special!(r)
    y = go_to_border_and_return_steps!(r, Up)
    go_to_border_and_return_steps!(r, Down)

    markers_to_do=go_to_border_and_return_steps!(r,Right; markers = true)
    go_back_pass_obstacles!(r, Left, markers_to_do)

    while y > 0 && markers_to_do > 0
        markers_to_do = markers_to_do
        go_back_pass_obstacles!(r, Up, 1)
        go_back_pass_obstacles!(r, Right, markers_to_do; markers = true, ignore_warning = true)
        go_to_border_and_return_steps!(r, Left)
        markers_to_do-=1
    end

    go_to_l_corner_special!(r)
    go_by_path_special!(r, path)
end

mark_bordered_field_by_stairs!(r)

# костыль, чтобы программа сразу же не закрылась и можно было посмотреть результат её работы
println("Спасибо за внимание!. Нажмите enter")
_ = readline()