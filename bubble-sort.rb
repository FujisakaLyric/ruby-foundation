def bubble_sort(array)
    (array.length - 1).downto(1) do |end_index|
        0.upto(end_index - 1) do |start_index|
            if array[start_index] > array[start_index + 1]
                temp = array[start_index + 1]
                array[start_index + 1] = array[start_index]
                array[start_index] = temp
            end
        end
    end
    array
end