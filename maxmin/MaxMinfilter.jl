module MaxMinFilter

using DataStructures
using Serialization

export max_min_filter_window, save_state, load_state

function max_min_filter_window(arr::Vector{Float64}, w::Int)
    len = length(arr) - w + 1
    max_vals = fill(0.0, len)
    min_vals = fill(0.0, len)
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

function save_state(filename::String, state)
    serialize(filename, state)
end

function load_state(filename::String)
    return deserialize(filename)
end

end
