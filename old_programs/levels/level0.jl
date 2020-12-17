function generateAndSaveSit(ss::AbstractString) 
    robot = Robot() 
    show!(robot)
    _ = readline()
    save(robot.situation, ss)
    println("сохранено как " * ss)
end