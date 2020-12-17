include("Robot/robot.jl")
include("basic_functions.jl")

function solutionForLevel(level::Int)
    r = Robot(; animate=false)
    
    if level == 1
        level1(r)
        println("1")
    elseif level ==2
        println("2")
        level2(r)
    elseif level == 3
        println("3")
        level3(r)
    elseif level == 4
        level4(r)
        println("4")
    elseif level == 5
        level5(r)
    elseif level == 6
        level6(r)
    elseif level == 7
        level7(r)
    elseif level == 8
        level8(r)
    elseif level == 9
        level9(r)
    elseif level == 10
        level10(r)
    elseif level == 11
        level11(r)
    elseif level == 12
        level12(r)
    elseif level == 13
        level13(r)
    elseif level == 0
        println("введите имя файла для сохранения")
        s = readline()
        generateAndSaveSit(s)
    else 
        println("неверный номер уровня")
    end
end

println("Введите номер уровня (1-13)")
n = parse(Int, readline())

#добавляется код для нужного уровня
levelName="levels/level";
levelName = levelName * string(n) * ".jl"

include(levelName)

#вызов решения для нужного уровня
solutionForLevel(n)

#последняя строка нужна, чтобы окно поля сразу же не закрылось
println("Программа завершена. Нажмите enter")
_ = readline()

