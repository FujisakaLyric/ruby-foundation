def merge_sort(array)
  return array if array.length == 1
  left_array = merge_sort(array.slice(0,(array.length / 2).floor))
  right_array = merge_sort(array.slice((array.length / 2).floor, array.length))
  left_index = 0
  right_index = 0
  new_array = []
  while left_index < left_array.length || right_index < right_array.length
    unless left_index < left_array.length
      new_array.concat(right_array.slice(right_index, right_array.length))
      return new_array
    end

    unless right_index < right_array.length
      new_array.concat(left_array.slice(left_index, left_array.length))
      return new_array
    end

    if left_array[left_index] <= right_array[right_index]
      new_array << left_array[left_index]
      left_index += 1
    else
      new_array << right_array[right_index]
      right_index += 1
    end
  end
  new_array
end

numbers_array = [5,2,3,8,4,1,6,7]
p merge_sort(numbers_array)