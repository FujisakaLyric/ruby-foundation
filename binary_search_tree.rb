class Node
  include Comparable
  attr_accessor :data, :left, :right

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end
end

class Tree
  attr_accessor :root

  def initialize(array)
    @root = build_tree(array.uniq.sort)
  end

  def build_tree(array)
    return nil if array.empty?

    # Takes the left node as root for even arrays
    mid_index = (array.length - 1)/2
    root = Node.new(array[mid_index])
    if mid_index == 0
      root.left = nil
    else
      root.left = build_tree(array[0..mid_index-1])
    end
    
    if mid_index == 0 && array.length == 1
      root.right = nil
    else
      root.right = build_tree(array[mid_index + 1..array.length])
    end
    root
  end
  
  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def insert(value, node = @root)
    return nil if value == node.data

    if value < node.data
      node.left.nil? ? node.left = Node.new(value) : insert(value, node.left)
    else
      node.right.nil? ? node.right = Node.new(value) : insert(value, node.right)
    end
  end

  def delete(value, node = @root)
    if value < node.data
      if node.left.nil?
        puts "Value does not exist."
        return nil
      else 
        node.left = delete(value, node.left)
      end
    elsif value > node.data
      if node.right.nil?
        puts "Value does not exist."
        return nil
      else
        node.right = delete(value, node.right)
      end
    else
      # Matching value
      p node

      # Node has 0-1 child
      return node.right if node.left.nil?
      return node.left if node.right.nil?

      # Node has 2 children
      next_predecessor = node.right
      next_predecessor = node.left until node.left.nil?
      node.data = next_predecessor.data
      node.right = delete(node.data, node.right)
    end
    node
  end

  def find(value)
    return nil if value.nil?
    node = @root
    until value == node.data
      if value < node.data
        node = node.left
        return nil if node.nil?
      else
        node = node.right
        return nil if node.nil?
      end
    end
    node
  end

  def level_order(node = @root, queue = [])
    array = []
    queue << node
    until queue[0].nil?
      yield(queue[0]) if block_given?
      array << queue[0].data
      queue << queue[0].left unless queue[0].left.nil?
      queue << queue[0].right unless queue[0].right.nil?
      queue.shift
    end
    array
  end

  def inorder(node = @root, array = [], &block)
    inorder(node.left, array, &block) unless node.left.nil?

    yield(node) if block_given?
    array << node.data

    inorder(node.right, array, &block) unless node.right.nil?
    array
  end

  def preorder(node = @root, array = [], &block)
    yield(node) if block_given?
    array << node.data

    preorder(node.left, array, &block) unless node.left.nil?
    preorder(node.right, array, &block) unless node.right.nil?
    array
  end

  def postorder(node = @root, array = [], &block)
    postorder(node.left, array, &block) unless node.left.nil?
    postorder(node.right, array, &block) unless node.right.nil?
    yield(node) if block_given?
    array << node.data
  end

  def height(node = @root)
    node = node.instance_of?(Node) ? find(node.data) : find(node)
    return -1 if node.nil?

    left = node.left ? height(node.left) : -1
    right = node.right ? height(node.right) : -1
    [left, right].max + 1
  end

  def depth(node = @root)
    ans = height(node)
    ans == -1 ? -1 : height(@root) - height(node)
  end

  def balanced?(node = @root)
    return true if node.nil?

    left = height(node.left)
    right = height(node.right)
    return true if (left - right).abs <= 1 && balanced?(node.left) && balanced?(node.right)
    false
  end

  def rebalance
    @root = build_tree(inorder())
  end

  def print_test
    puts ""
    puts "Is BST balanced? #{self.balanced?}."
    puts "Level-order: #{self.level_order}"
    puts "Preorder: #{self.preorder}"
    puts "Preorder: #{self.postorder}"
    puts "Inorder: #{self.inorder}"
    puts ""
  end
end

array = Array.new(15) {rand(1..100)}
bst = Tree.new(array)
bst.pretty_print
bst.print_test

10.times do
  a = rand(100..150)
  bst.insert(a)
end

bst.pretty_print
puts ""
puts "Is updated BST balanced? #{bst.balanced?}."
puts ""
bst.rebalance
bst.pretty_print
bst.print_test