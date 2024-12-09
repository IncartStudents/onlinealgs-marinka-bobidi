# function max_min_filter_clas(arr::Vector{Int})
#   max_val = arr[1]
#   min_val = arr[1]
#   comparisons_max = 0
#   comparisons_min = 0

#   for i in 1:length(arr)
#       comparisons_max += 1
#       if arr[i] > max_val
#           max_val = arr[i]
#       end
#   end

#   for i in 1:length(arr)
#       comparisons_min += 1
#       if arr[i] < min_val
#           min_val = arr[i]
#       end
#   end
  
#   println("Сравнений для макс классика: $comparisons_max, Сравнений для мин классика: $comparisons_min")
  
#   return max_val, min_val
# end

# # Пример использования функции
# arr = [7, 9, 3, 4, 7]
# max_val, min_val = max_min_filter_clas(arr)
# println("max: $max_val, min: $min_val")
using Plots

x = 1:10
y = rand(10)

plot(x, y, label="Random Data")
display(plot(x, y, label="Random Data"))
