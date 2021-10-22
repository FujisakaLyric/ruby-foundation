class LinkedList
  attr_reader :head, :tail, :size

  def initialize
    @head = nil
    @tail = nil
    @size = 0
  end

  def append(value)
    new_node = Node.new(value)
    @head ||= new_node

    if @tail
      @tail.next_node = new_node
    end

    @size += 1
    @tail = new_node
  end

  def prepend(value)
    new_node = Node.new(value, @head)
    @tail ||= new_node
    @size += 1
    @head = new_node
  end

  def at(index)
    curr_node = @head

    index.times do 
      return nil if curr_node == nil
      curr_node = curr_node.next_node
    end
    curr_node
  end

  def pop
    return nil if @tail == nil

    curr_node = @tail
    if @head == @tail
      @head == nil
      @tail == nil
    else
      new_tail = @head
      while new_tail.next_node != curr_node
        new_tail = new_tail.next_node
      end
      new_tail.next_node = nil
      @tail = new_tail
    end

    @size -= 1
    curr_node
  end

  def contains?(value)
    curr_node = @head

    until curr_node.nil?
      return true if curr_node.value == value
      curr_node = curr_node.next_node
    end
    false
  end

  def find(value)
    curr_node = @head
    counter = 0
    until curr_node.nil?
      return counter if curr_node.value == value
      curr_node = curr_node.next_node
      counter += 1
    end
    nil
  end

  def to_s
    curr_node = @head
    print_array = []
    until curr_node.nil?
      print_array << curr_node.value
      curr_node = curr_node.next_node
    end
    print_array << "nil"
    result = print_array.join(" -> ")
  end

  def insert_at(value, index)
    return self.prepend(value) if index == 0

    prev_node = self.at(index - 1)
    next_node = self.at(index)
    if prev_node.nil?
      puts "Index selected is out of LinkedList range. Appending new value at the end."
      curr_node = self.append(value)
    elsif next_node.nil?
      curr_node = self.append(value)
    else
      curr_node = Node.new(value)
      curr_node.next_node = next_node
      prev_node.next_node = curr_node
      @size += 1
    end
    curr_node
  end
  
  def remove_at(index)
    prev_node = self.at(index - 1)
    curr_node = self.at(index)
    next_node = self.at(index + 1)

    if curr_node.nil?
      puts "Index selected is out of LinkedList range."
      return
    elsif next_node.nil?
      return self.pop
    elsif index == 0
      @head = next_node
      curr_node.next_node = nil
      @size -= 1
    else
      prev_node.next_node = next_node
      curr_node.next_node = nil
      @size -= 1
    end
    curr_node
  end
end

class Node
  attr_accessor :next_node, :value

  def initialize(value = nil, next_node = nil)
    @value = value
    @next_node = next_node
  end
end