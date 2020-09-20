include("Robot/robot.jl")
function solutionForLevel(level::Int)
    r = Robot(; animate=false)
    loadMapForLevel(level)
    if level == 1
        level1(r)
    elseif level ==2
        level2(r)
    elseif level == 3
        level3(r)
    elseif level == 4
        level4(r)
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
    end
end

function putmarkers!(r::Robot, side::DirectionsOfMovement)
    while isborder(r,side)==false
        move!(r,side)
        putmarker!(r)
    end
end

inverse(side::DirectionsOfMovement) = DirectionsOfMovement(mod(Int(side)+2, 4)) 

move_by_markers(r::Robot,side::DirectionsOfMovement) = while ismarker(r)==true 
    move!(r,side) 
end

function moves!(r::Robot,side::DirectionsOfMovement)
    num_steps=0
    while isborder(r,side)==false
        move!(r,side)
        num_steps+=1
    end
    return num_steps
end

function moves!(r::Robot,side::DirectionsOfMovement,num_steps::Int)
    for _ in 1:num_steps # символ "_" заменяет фактически не используемую переменную
        move!(r,side)
    end
end

function level1(r)
    println("level1")
    r = Robot(; animate=true)

    for side in (DirectionsOfMovement(i) for i=0:3) # - перебор всех возможных направлений
        putmarkers!(r,side)
        move_by_markers(r, inverse(side))
    end
    putmarker!(r)
end

function level2(r)
    println("level2")
    r = Robot(; animate=true)
    #движемся в левый нижний угол
    num_vert = moves!(r, Down)
    num_hor = moves!(r, Left)
    #ставим маркеры по кругу
    putmarkers!(r, Up) 
    putmarkers!(r, Right)  
    putmarkers!(r, Down)
    putmarkers!(r, Left)  
    #возвращаемся в исходную точку
    moves!(r, Up, num_vert)
    moves!(r, Right, num_hor)
end

function level3(r)
    println("level3")
    r=Robot("situation_3.sit")
    show(r)
end

function level4(r)
    println("level4")
    show(r)
end

function level5(r)
    println("level5")
    show!(r)
    _ = readline()
    save(r, "situation3.sit")
end

function level6(r)
    println("level6")
    r=Robot("situation_6.sit")
    show(r)
end

function level7(r)
    println("level7")
    show(r)
end

function level8(r)
    println("level8")
    show(r)
end

function level9(r)
    println("level9")
    show(r)
end

function level10(r)
    println("level10")
    show(r)
end

function loadMapForLevel(level::Int)
    #загрузить карту
    println("загружена карта для уровня ", string(level))
end

function generateAndSaveSit(ss::AbstractString) 
    robot = Robot() 
    show!(robot)
    _ = readline()
    save(robot.situation, ss)
    println("сохранено как" * ss)

end
println("Введите номер уровня")
n = parse(Int, readline())
#generateAndSaveSit("new3.sit")
solutionForLevel(n)
println("Программа завершена. Нажмите enter")
_ = readline()