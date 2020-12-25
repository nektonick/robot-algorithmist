include("core_lib/HorizonSideRobots.jl")
using .HorizonSideRobots
include("core_lib/my_lib.jl") 

r=Robot("level_maps/situation_18.sit"; animate=true)

function mark_corners_on_fiel_with_borders!(r::Robot)
    path = go_to_l_corner_special!(r)

    for side in (Nord, Ost, Sud, West)
        go_to_border_and_return_steps!(r, side)
        putmarker!(r)
    end

    go_by_path_special!(r, path)
end

mark_corners_on_fiel_with_borders!(r)
# костыль, чтобы программа сразу же не закрылась и можно было посмотреть результат её работы
println("Спасибо за внимание!. Нажмите enter")
_ = readline()