# -*- coding: utf-8 -*-
# Builder - 複雑なインスタンスを組み立てる

class Node
  attr_reader :name, :nodes
  def initialize(name)
    @name = name
    @nodes = []
  end
end

# わかりにくい

root = Node.new("root")
root.nodes << Node.new("a")
root.nodes << Node.new("b")
root.nodes << (c = Node.new("c"))
c.nodes << Node.new("d")
c.nodes << Node.new("e")
c.nodes << (f = Node.new("f"))
f.nodes << Node.new("g")
f.nodes << Node.new("h")

root.nodes.collect{|e|e.name}                       # => ["a", "b", "c"]
root.nodes.last.nodes.collect{|e|e.name}            # => ["d", "e", "f"]
root.nodes.last.nodes.last.nodes.collect{|e|e.name} # => ["g", "h"]

# 改善

class Builder
  attr_reader :root

  def self.build(*args, &block)
    new(*args).tap(&block).root
  end

  def initialize(root = nil)
    @root = root || Node.new("root")
  end

  def <<(name)
    @root.nodes << Node.new(name)
  end

  def directory(name)
    node = Node.new(name)
    yield self.class.new(node)
    @root.nodes << node
  end
end

root = Builder.build do |o|
  o << "a"
  o << "b"
  o.directory("c") do |c|
    c << "d"
    c << "e"
    c.directory("f") do |f|
      f << "g"
      f << "h"
    end
  end
end

root.nodes.collect{|e|e.name}                       # => ["a", "b", "c"]
root.nodes.last.nodes.collect{|e|e.name}            # => ["d", "e", "f"]
root.nodes.last.nodes.last.nodes.collect{|e|e.name} # => ["g", "h"]
