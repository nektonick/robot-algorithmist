include("core_lib/HorizonSideRobots.jl")
using .HorizonSideRobots
include("core_lib/my_lib.jl") 

r=Robot("level_maps/situation_14.sit"; animate=true)

function mark_simple_cross()
    for side in (Up, Left, Right, Down)
        num_of_steps = put_markers!(r, side)

        smart_movement!(r,inverse_side(side), num_of_steps)
    end
    if !ismarker(r)
        putmarker!(r)
    end
end

function put_markers!(r::Robot,side::HorizonSide)
    num_of_steps=0 
    while move_if_possible!(r, side) == true
        if !(ismarker(r))
            putmarker!(r)
        end
        num_of_steps += 1
    end 
    return num_of_steps
end

function smart_movement!(r::Robot, side::HorizonSide, num_of_steps::Int) 
    for _ in 1:num_of_steps
        move_if_possible!(r,side)
    end
end


mark_simple_cross()

# костыль, чтобы программа сразу же не закрылась и можно было посмотреть результат её работы
println("Спасибо за внимание!. Нажмите enter")
_ = readline()