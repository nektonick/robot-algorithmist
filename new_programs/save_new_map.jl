include("core_lib/HorizonSideRobots.jl")
using .HorizonSideRobots
include("core_lib/my_lib.jl") 

println("введите имя файла для сохранения вместе с расширением")
s = readline()
robot = Robot(20, 20) 
show!(robot)
println("Нажмите enter, когда закончите редактирование")
_ = readline()
save(robot.situation, s)
println("сохранено как " * s)

# костыль, чтобы программа сразу же не закрылась и можно было посмотреть результат её работы
println("Спасибо за внимание!. Нажмите enter")
_ = readline()