function level9(r)
    println("level9")
    r=Robot("levels/situation_9.sit"; animate=true)

    num_steps=1
    side=Up
    while ismarker(r)==false
        for _ in 1:2
            find_marker(r,side,num_steps)
            side=nextDirection(side)
        end
        num_steps+=1
    end 
end

function find_marker(r,side,num_steps)
    for _ in 1:num_steps
        if ismarker(r)
            return nothing
        end
        move!(r,side)
    end
end