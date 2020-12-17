# Общая информация

Теперь в репозитории находятся две папки: `new_programs` и `old_programs` - первая использует новую версию библиотеки робота `HorizonSideRobots.jl` и не содержит изменений в самой библиотеке. Вторая же использует старый и модифицированный файл `robot.jl`.

# Запуск

На windows 10 запускать из терминала командой `julia .\robot-1-0.jl` находясь при этом в папке `robot-algorithmist/old_programs` для старых программ. (Далее в консоли будет предложено выбрать уровень 1-13).
Для новых программ следует выполнять команду `julia *имя файла уровня*` (например, `julia level14.jl`) находясь при этом в папке `robot-algorithmist/new_programs`. 

# Зависимости

- Python 3 c библиотекой matplotlib
- Julia
- Графический пакет PyPlot.jl

Подробнее - [тут](https://github.com/Vibof/HorizonSideRobots.jl/blob/master/content/setup.md) или [тут](https://github.com/Vibof/Robot/blob/master/setup.md).

# Детали

Файл `robot.jl` находящийся в `robot-algorithmist\old_programs\Robot` был модифициорован. Так, например, направление сторон света были заменены на "Up, Down, Left, Right", была изменена команда `save`. Впрочем, основная функциональность кода не была изменена