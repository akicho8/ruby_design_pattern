## Builder ##

### 例1 ###

# 改善前

# AddressContainer なんて利用者にとっては知らなくていいもの

#+BEGIN_SRC
class AddressContainer
  def initialize(address)
    @address = address
  end
end

class Mail
  attr_accessor :to
end

mail = Mail.new
mail.to = AddressContainer.new("alice <alice@example.net>")
#+END_SRC

# 改善後

#+BEGIN_SRC
class Mail
  attr_reader :to

  def to=(address)
    @to = AddressContainer.new(address)
  end
end

mail = Mail.new
mail.to = "alice <alice@example.net>"
#+END_SRC

### 例2 ###

# 改善前

#+BEGIN_SRC
class Node
  attr_reader :name, :children

  def initialize(name)
    @name = name
    @children = []
  end
end
#+END_SRC

# これは使いづらそう

#+BEGIN_SRC
root = Node.new("root")
root.children << Node.new("a")
root.children << Node.new("b")
root.children << (c = Node.new("c"))
c.children << Node.new("d")
c.children << Node.new("e")
c.children << (f = Node.new("f"))
f.children << Node.new("g")
f.children << Node.new("h")

root.children.collect(&:name)                             # => ["a", "b", "c"]
root.children.last.children.collect(&:name)               # => ["d", "e", "f"]
root.children.last.children.last.children.collect(&:name) # => ["g", "h"]
#+END_SRC

# 改善後

#+BEGIN_SRC
class Node
  def add(name, &block)
    tap do
      node = self.class.new(name)
      @children << node
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

root.children.collect(&:name)                             # => ["a", "b", "c"]
root.children.last.children.collect(&:name)               # => ["d", "e", "f"]
root.children.last.children.last.children.collect(&:name) # => ["g", "h"]
#+END_SRC
