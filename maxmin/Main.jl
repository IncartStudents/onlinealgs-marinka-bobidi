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

filename = "./all_MX120161018125923.bin"
range = 1:1000
channel_index = 1

# Чтение данных
data, fs, timestart, units = Readers.readbin(filename, range)

window_size = 3
state_file = "state.dat"

results = []

channel_data = data[channel_index]
for value in channel_data
    max_vals, min_vals = max_min_filter_online(state, value)
    save_state(state_file, state)
end
results = (channel_index, state.max_vals, state.min_vals)

index, max_vals, min_vals = results
p = plot(max_vals, label="Max (Канал $index)", lw=2, legend=:topleft)
plot!(p, min_vals, label="Min (Канал $index)", lw=2, legend=:topleft)
display(p)
