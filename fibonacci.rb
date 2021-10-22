def fibs(num)
  array = []
  num.times do |index|
    if index == 0
      array << 0
    elsif index == 1
      array << 1
    else
      array << (array[index - 1] + array[index - 2])
    end
  end
  array
end

def fibs_rec(num, array = [])
  return [] if num == 0
  return array << 0 if num == 1
  return [0, 1] if num == 2
  array = fibs_rec(num - 1, array)
  array << (array[array.length - 1] + array[array.length - 2])
  array
end