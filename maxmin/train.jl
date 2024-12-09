using DataStructures
using Plots

function max_min_filter_window(arr::Vector{Int}, w::Int)
    max_vals = fill(0, length(arr)-w+1)
    min_vals = fill(0, length(arr)-w+1)
    U = Deque{Int}()
    L = Deque{Int}()

    for i in 2:length(arr)
        if i >= w
            if length(U) > 0 
                max_vals[i-w+1] = arr[first(U)]
            else
                max_vals[i-w+1] = arr[i-1]
            end
            if length(L) > 0
                min_vals[i-w+1] = arr[first(L)]
            else
                min_vals[i-w+1] = arr[i-1]
            end
        end
        
        if arr[i] > arr[i-1]
            push!(L, i-1)
            if i == w + first(L)
                pop!(L)
            end
            while length(U) > 0
                if arr[i] <= arr[last(U)]
                    if i == w + first(U)
                        pop!(U)
                    end
                    break
                end
                pop!(U)
            end
        else
            push!(U, i-1)
            if i == w+first(U)
                pop!(U)
            end
            while length(L) > 0
                if arr[i] >= arr[last(L)]
                    if i == w+first(L)
                        pop!(L)
                    end
                    break
                end
                pop!(L)
            end
        end
    end
    
 # Условие для maxval
max_vals[length(arr) - w + 1 ] = length(U) > 0 ? arr[first(U)] : arr[length(arr)]

# Условие для minval
min_vals[length(arr) - w + 1] = length(L) > 0 ? arr[first(L)] : arr[length(arr)]


    return max_vals, min_vals
end

# Пример использования функции
arr = [5, 8, 7, 9, 3, 4, 5, 8, 5]
w = 3
max_vals, min_vals = max_min_filter_window(arr, w)

# Построение графика
plot(max_vals, label="Max Values", lw=2, seriestype=:scatter)
plot!(min_vals, label="Min Values", lw=2, seriestype=:scatter)
