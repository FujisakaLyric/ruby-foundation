module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    if self.is_a?(Array)
      self.length.times { |index| yield(self[index]) }
    else
      self.keys.length.times { |key_index| yield(self.keys[key_index], self[self.keys[key_index]]) }
    end
    self
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?
    
    if self.is_a?(Array)
      self.length.times { |index| yield(self[index], index) }
    else
      self.keys.length.times { |key_index| yield(self.assoc(self.keys[key_index]), key_index) }
    end
    self
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    if self.is_a?(Array)
      result = []
      self.length.times do |index| 
        result << self[index] if yield(self[index])
      end
    else
      result = {}
      self.keys.length.times do |key_index| 
        result[self.keys[key_index]] = self[self.keys[key_index]] if yield(self.assoc(self.keys[key_index]))
      end
    end
    result
  end

  def my_all?
    if self.is_a?(Array)
      unless block_given?
        self.length.times { |index| return false if self[index] == false || self[index] == nil }
      else
        self.length.times { |index| return false unless yield(self[index]) }
      end
    else
      unless block_given?
        self.keys.length.times { |key_index| return false if self[self.keys[key_index]] == false || self[self.keys[key_index]] == nil }
      else
        self.keys.length.times { |key_index| return false unless yield(self.assoc(self.keys[key_index])) }
      end
    end
    true
  end

  def my_any?
    if self.is_a?(Array)
      unless block_given?
        self.length.times { |index| return true unless self[index] == false || self[index] == nil }
      else
        self.length.times { |index| return true if yield(self[index]) }
      end
    else
      unless block_given?
        self.keys.length.times { |key_index| return true unless self[self.keys[key_index]] == false || self[self.keys[key_index]] == nil }
      else
        self.keys.length.times { |key_index| return true if yield(self.assoc(self.keys[key_index])) }
      end
    end
    false
  end

  def my_none?
    if self.is_a?(Array)
      unless block_given?
        self.length.times { |index| return false unless self[index] == false || self[index] == nil }
      else
        self.length.times { |index| return false if yield(self[index]) }
      end
    else
      unless block_given?
        self.keys.length.times { |key_index| return false unless self[self.keys[key_index]] == false || self[self.keys[key_index]] == nil }
      else
        self.keys.length.times { |key_index| return false if yield(self.assoc(self.keys[key_index])) }
      end
    end
    true
  end

  def my_count (arg = nil)
    count = 0
    if arg != nil
      if self.is_a?(Array)
        self.length.times { |index| count += 1 if self[index] == arg }
      else
        self.keys.length.times { |key_index| count += 1 if self[self.keys[key_index]] == arg }
      end
    elsif block_given?
      if self.is_a?(Array)
        self.length.times { |index| count += 1 if yield(self[index]) }
      else
        self.keys.length.times { |key_index| count += 1 if yield(self.assoc(self.keys[key_index])) }
      end
    else
      if self.is_a?(Array) 
        count = self.length
      else
        count = self.keys.length
      end
    end
    count
  end

  def my_map (proc = nil)
    new_array = []
    unless proc == nil
      if self.is_a?(Array)
        self.length.times do |index| 
          new_array << proc.call(self[index]) 
        end
      else
        self.keys.length.times do |key_index| 
          new_array << proc.call(self.assoc(self.keys[key_index]))
        end
      end
      return new_array
    end

    return to_enum(:my_map) unless block_given?

    if self.is_a?(Array)
      self.length.times { |index| new_array << yield(self[index]) }
    else
      self.keys.length.times { |key_index| new_array << yield(self.assoc(self.keys[key_index])) }
    end
    new_array
  end

  def my_inject (accumulator = nil)
    self.size.times do |index|
      if accumulator == nil && index == 0
        accumulator = self[index]
        next
      end
      accumulator = yield(accumulator, self[index])    
    end
    accumulator
  end

  def multiply_els
    self.my_inject { |acc, item| acc * item}
  end
end

# 1. my_each vs each
# numbers_array = [1, 2, 3, 4, 5]
# p numbers_array.my_each { |item| puts item }
# p numbers_array.each  { |item| puts item }

# numbers_hash = { a: "Apple", b: "Banana", c: "Cherry" }
# p numbers_hash.my_each { |key, item| puts "Key \"#{key}\": #{item}"}
# p numbers_hash.each  { |key, item| puts "Key \"#{key}\": #{item}" }


# 2. my_each_with_index vs each_with_index
# numbers_array = [1, 2, 3, 4, 5]
# p numbers_array.my_each_with_index { |item, index| puts "Index #{index}: #{item}" }
# p numbers_array.each_with_index  { |item, index| puts "Index #{index}: #{item}" }

# numbers_hash = { a: "Apple", b: "Banana", c: "Cherry" }
# p numbers_hash.my_each_with_index { |(key, item), index| puts "Index \"#{index}\" - Key \"#{key}\": #{item}" }
# p numbers_hash.each_with_index { |(key, item), index| puts "Index \"#{index}\" - Key \"#{key}\": #{item}" }


# 3. my_select vs select
# numbers_array = [1, 2, 3, 4, 5]
# p numbers_array.my_select { |item| item.odd? }
# p numbers_array.select  { |item| item.odd? }

# numbers_hash = { a: "Apple", b: "Banana", c: "Cherry" }
# p numbers_hash.my_select { |key, item| item.length == 5 || key == :c }
# p numbers_hash.select { |key, item| item.length == 5 || key == :c }


# 4. my_all? vs all?
# numbers_array = [1, 2, 3, 4, 5]
# p numbers_array.my_all? { |item| item < 6 }
# p numbers_array.all? { |item| item < 6 }
# p numbers_array.my_all? { |item| item > 3 }
# p numbers_array.all? { |item| item > 3 }

# numbers_hash = { a: "Apple", b: "Banana", c: "Cherry" }
# p numbers_hash.my_all? { |key, item| item.length == 6 }
# p numbers_hash.all? { |key, item| item.length == 6 }
# p numbers_hash.my_all? { |key, item| item.length >= 5 }
# p numbers_hash.all? { |key, item| item.length >= 5 }


# 5. my_any? vs any?
# numbers_array = [1, 2, 3, 4, 5]
# p numbers_array.my_any? { |item| item >= 6 }
# p numbers_array.any? { |item| item >= 6 }
# p numbers_array.my_any? { |item| item > 3 }
# p numbers_array.any? { |item| item > 3 }

# numbers_hash = { a: "Apple", b: "Banana", c: "Cherry" }
# p numbers_hash.my_any? { |key, item| item.length > 5 }
# p numbers_hash.any? { |key, item| item.length > 5 }
# p numbers_hash.my_any? { |key, item| item.length < 5 }
# p numbers_hash.any? { |key, item| item.length < 5 }


# 6. my_none? vs none?
# numbers_array = [1, 2, 3, 4, 5]
# p numbers_array.my_none? { |item| item >= 6 }
# p numbers_array.none? { |item| item >= 6 }
# p numbers_array.my_none? { |item| item > 3 }
# p numbers_array.none? { |item| item > 3 }

# numbers_hash = { a: "Apple", b: "Banana", c: "Cherry" }
# p numbers_hash.my_none? { |key, item| item.length > 6 }
# p numbers_hash.none? { |key, item| item.length > 6 }
# p numbers_hash.my_none? { |key, item| item.length <= 5 }
# p numbers_hash.none? { |key, item| item.length <= 5 }


# 7. my_count vs count
# numbers_array = [1, 2, 3, 3, 4, 5]
# p numbers_array.my_count
# p numbers_array.count
# p numbers_array.my_count(3)
# p numbers_array.count(3)
# p numbers_array.my_count { |item| item >= 3 }
# p numbers_array.count { |item| item >= 3 }

# numbers_hash = { a: "Apple", b: "Banana", c: "Cherry", d: "Banana"}
# p numbers_hash.my_count
# p numbers_hash.count
# p numbers_hash.my_count { |key, item| item.length > 5 }
# p numbers_hash.count { |key, item| item.length > 5 }


# 8. my_map vs map
# numbers_array = [1, 2, 3, 3, 4, 5]
# p numbers_array.my_map { |item| item ** 2 }
# p numbers_array.map { |item| item ** 2 }

# numbers_hash = { a: "Apple", b: "Banana", c: "Cherry", d: "Banana"}
# p numbers_hash.my_map { |key, item| item.length > 5 }
# p numbers_hash.map { |key, item| item.length > 5 }


# 9. my_inject vs inject
# numbers_array = [1, 2, 3, 3, 4, 5]
# p numbers_array.my_inject { |acc, item| acc + item }
# p numbers_array.inject { |acc, item| acc + item }
# p numbers_array.my_inject(51) { |acc, item| acc + item }
# p numbers_array.inject(51) { |acc, item| acc + item }


# 10. multiply_els
# numbers_array = [1, 2, 3, 3, 4, 5]
# p numbers_array.multiply_els


# 11-12. my_map with proc
# numbers_array = [1, 2, 3, 3, 4, 5]
# array_proc = Proc.new { |item| item ** 2 }
# p numbers_array.my_map(array_proc)
# p numbers_array.my_map(array_proc) { |item| item ** 5 }

# numbers_hash = { a: "Apple", b: "Banana", c: "Cherry", d: "Banana"}
# hash_proc = Proc.new { |key, item| item.length > 5 }
# p numbers_hash.my_map(hash_proc)
# p numbers_hash.my_map(hash_proc) { |key, item| item.length > 6 }