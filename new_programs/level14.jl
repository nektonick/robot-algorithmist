include("core_lib/HorizonSideRobots.jl")
using .HorizonSideRobots
include("core_lib/my_lib.jl") 

r=Robot("level_maps/situation_14.sit"; animate=true)

function mark_simple_cross!(r::Robot)
    for side in (Up, Left, Right, Down)
        num_of_steps = go_to_border_and_return_steps!(r,side; markers = true)
        go_back_pass_obstacles!(r, inverse_side(side), num_of_steps)
    end
end

mark_simple_cross!(r::Robot)

# костыль, чтобы программа сразу же не закрылась и можно было посмотреть результат её работы
println("Спасибо за внимание!. Нажмите enter")
_ = readline()