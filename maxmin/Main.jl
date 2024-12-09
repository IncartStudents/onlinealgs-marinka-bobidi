using Pkg
Pkg.add("DataStructures")
Pkg.add("Plots")
Pkg.add("Serialization")
Pkg.add("CSV")
Pkg.add("DataFrames")

include("./Readers.jl")
include("./MaxMinFilter.jl")

using Plots
using .Readers
using .MaxMinFilter

# Пример использования функций
filename = "/all_MX120161018125923.bin"
range = 1:1000  # Диапазон данных
channel_to_process = "Channel1"  # Имя канала для обработки

# Чтение данных
data, fs, timestart, units = Readers.readbin(filename, range)

# Инициализация состояния для онлайн-реализации фильтра
window_size = 3
state_file = "state.dat"

# Проверка существования файла состояния для загрузки или инициализации нового
if isfile(state_file)
    state = load_state(state_file)
else
    state = init_filter_state(window_size)
end

results = []

# Пример обработки данных онлайн для одного канала
channel_data = data[channel_to_process]
for value in channel_data
    max_vals, min_vals = max_min_filter_online(state, value)
end
results = (channel_to_process, state.max_vals, state.min_vals)
save_state(state_file, state)  # Сохранение состояния после обработки канала

# Визуализация результатов
channel, max_vals, min_vals = results
p = plot(max_vals, label="Max  ($channel)", lw=2, legend=:topleft)
plot!(p, min_vals, label="Min  ($channel)", lw=2, legend=:topleft)
display(p)
