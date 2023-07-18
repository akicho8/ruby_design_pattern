# Builder - 複雑なインスタンスを組み立てる

class Node
  attr_reader :name, :nodes
  def initialize(name)
    @name = name
    @nodes = []
  end
end

# 汚い

root = Node.new("root")
root.nodes << Node.new("a")
root.nodes << Node.new("b")
root.nodes << (c = Node.new("c"))
c.nodes << Node.new("d")
c.nodes << Node.new("e")
c.nodes << (f = Node.new("f"))
f.nodes << Node.new("g")
f.nodes << Node.new("h")

root.nodes.collect {|e|e.name}                       # => ["a", "b", "c"]
root.nodes.last.nodes.collect {|e|e.name}            # => ["d", "e", "f"]
root.nodes.last.nodes.last.nodes.collect {|e|e.name} # => ["g", "h"]

# 改善

class Node
  def add(name, &block)
    tap do
      node = self.class.new(name)
      @nodes << node
      if block_given?
        node.instance_eval(&block)
      end
    end
  end
end

root = Node.new("root")
root.instance_eval do
  add "a"
  add "b"
  add "c" do
    add "d"
    add "e"
    add "f" do
      add "g"
      add "h"
    end
  end
end

root.nodes.collect {|e|e.name}                       # => ["a", "b", "c"]
root.nodes.last.nodes.collect {|e|e.name}            # => ["d", "e", "f"]
root.nodes.last.nodes.last.nodes.collect {|e|e.name} # => ["g", "h"]
