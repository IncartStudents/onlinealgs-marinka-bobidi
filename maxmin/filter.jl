using Plots

function max_min_filter_window(arr::Vector{Int}, w::Int)
    comparisons_max = 0
    comparisons_min = 0
    n = length(arr)
    max_vals = []
    min_vals = []
    U=[]
    L=[]

    for i in 1:(n - w + 1)
        window_max = -Inf
        window_min = Inf

        for j in i:(i + w - 1)
            comparisons_max += 1
            if arr[j] > window_max
                window_max = arr[j]
                push!(U, window_max)
            end
              for k in length(U):-1:2
              if U[k]> U[k-1] 
                deleteat!(U, k-1)
              end
            end


            comparisons_min += 1
            if arr[j] < window_min
                window_min = arr[j]
                push!(L, window_min)
            end
            for k in length(L):-1:2
              if L[k]< L[k-1]
                deleteat!(L, k-1)
              end
            end
        end

        push!(max_vals, window_max)
        push!(min_vals, window_min)
    end
    println(U)
    println(L)
    println("Сравнений для макс: $comparisons_max, Сравнений для мин: $comparisons_min")
    return max_vals, min_vals, U, L 
end

# Пример использования функции
arr = [7, 9, 3, 4, 7, 5, 3, 6, 2, 6]
w = 3
max_vals, min_vals, U,L= max_min_filter_window(arr, w)

# Построение графика
plot(U, label="Max Values", lw=2, seriestype=:scatter)
plot!(L, label="Min Values", lw=2, seriestype=:scatter)


