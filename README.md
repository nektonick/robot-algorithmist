# Запуск

На windows 10 запускать из терминала vs code командой `julia .\robot-1-0.jl` находясь при этом в папке `robot-algorithmist`
__Все команды__ `include` __уже находятся в файле__ `robot-1-0.jl`__. Ничего дополнительно прописывать не нужно.__

# Зависимости

- Python 3 c библиотекой matplotlib
- Julia
- Графический пакет PyPlot.jl

Подробнее - [тут](https://github.com/Vibof/HorizonSideRobots.jl/blob/master/content/setup.md) или [тут](https://github.com/Vibof/Robot/blob/master/setup.md).

# Детали
В файл `robot.jl` были внесены небольшие изменения в целях удобства. Например, направление сторон света были заменены на "Up, Down, Left, Right". 
Впрочем, основная функциональность кода не была изменена