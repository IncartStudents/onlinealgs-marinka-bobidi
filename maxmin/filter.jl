using DataStructures
using Plots

function max_min_filter_window(arr::Vector{Float64}, w::Int)
    max_vals = fill(0.0, length(arr) - w + 1)
    min_vals = fill(0.0, length(arr) - w + 1)
    U = Deque{Int}()
    L = Deque{Int}()

    for i in 1:length(arr)
        if length(U) > 0 && first(U) <= i - w
            popfirst!(U)
        end
        if length(L) > 0 && first(L) <= i - w
           popfirst!(L)
        end
        
    
        while length(U) > 0 && arr[last(U)] <= arr[i]
            pop!(U)
        end
        while length(L) > 0 && arr[last(L)] >= arr[i]
            pop!(L)
        end
        push!(U, i)
        push!(L, i)

        if i >= w
            max_vals[i - w + 1] = arr[first(U)]
            min_vals[i - w + 1] = arr[first(L)]
        end
    end

    return max_vals, min_vals
end

# Пример использования функции
t = 0:0.1:10
arr = sin.(t) * 2 +sin.(2t) * 4 + 4sin.(3t) * 5
w = 3
max_vals, min_vals = max_min_filter_window(arr, w)

# Построение графика
scatter(max_vals, label="Max Values", lw=2, legend=:topleft)
scatter!(min_vals, label="Min Values", lw=2, legend=:topleft)
