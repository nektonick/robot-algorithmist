include("core_lib/HorizonSideRobots.jl")
using .HorizonSideRobots
include("core_lib/my_lib.jl") 

r=Robot("level_maps/situation_15.sit"; animate=true)

function mark_perimetr!(r::Robot)
    x = go_to_border_and_return_steps!(r, Left)
    y = go_to_border_and_return_steps!(r,Down)
    
    for i ∈ (Up, Right, Down, Left)
        go_to_border_and_return_steps!(r, i; markers = true)
    end
    
    go_back_pass_obstacles!(r, Up, y)
    go_back_pass_obstacles!(r, Right, x)

end

mark_perimetr!(r)

# костыль, чтобы программа сразу же не закрылась и можно было посмотреть результат её работы
println("Спасибо за внимание!. Нажмите enter")
_ = readline()