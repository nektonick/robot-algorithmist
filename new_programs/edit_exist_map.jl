include("core_lib/HorizonSideRobots.jl")
using .HorizonSideRobots
include("core_lib/my_lib.jl") 

println("введите имя файла для сохранения вместе с расширением (файл должен лежать в папке level_maps)")
s = readline()::AbstractString
robot = Robot("level_maps/" * s; animate=true) 
println("Нажмите enter, когда закончите редактирование")
_ = readline()
save(robot.situation, "level_maps/" * s)
println("сохранено как " * s)