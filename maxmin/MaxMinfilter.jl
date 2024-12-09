module MaxMinFilter

using DataStructures
using Serialization

export FilterState, max_min_filter_online, init_filter_state, save_state, load_state

struct FilterState
    arr::Vector{Float64}
    max_vals::Vector{Float64}
    min_vals::Vector{Float64}
    U::Deque{Int}
    L::Deque{Int}
    w::Int
end

function init_filter_state(w::Int)
    return FilterState([], [], [], Deque{Int}(), Deque{Int}(), w)
end

# Онлайн функция для фильтрации
function max_min_filter_online(state::FilterState, new_value::Float64)
    append!(state.arr, [new_value])
    leng = length(state.arr)
    U = state.U
    L = state.L
    w = state.w
    if length(U) > 0 && first(U) <= leng - w
        popfirst!(U)
    end
    if length(L) > 0 && first(L) <= leng - w
        popfirst!(L)
    end

    while length(U) > 0 && state.arr[last(U)] <= new_value
        pop!(U)
    end
    while length(L) > 0 && state.arr[last(L)] >= new_value
        pop!(L)
    end
    push!(U, leng)
    push!(L, leng)

    if leng >= w
        max_val = state.arr[first(U)]
        min_val = state.arr[first(L)]
        append!(state.max_vals, [max_val])
        append!(state.min_vals, [min_val])
    end

    return state.max_vals, state.min_vals
end

# Функции для сохранения и загрузки состояния
function save_state(filename::String, state::FilterState)
    serialize(filename, state)
end

function load_state(filename::String)::FilterState
    return deserialize(filename)
end

end  
