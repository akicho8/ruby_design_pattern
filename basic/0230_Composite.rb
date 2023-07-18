## Composite ##

#+BEGIN_SRC
class Node
  attr_accessor :left, :expr, :right

  def initialize(left, expr, right)
    @left = left
    @expr = expr
    @right = right
  end

  def to_s
    "(" + [@expr, @left, @right] * " " + ")"
  end
end

a = Node.new(1, :+, 2)
b = Node.new(3, :+, 4)
c = Node.new(a, :*, b)
c.to_s                          # => "(* (+ 1 2) (+ 3 4))"
#+END_SRC

# 再帰的に to_s が呼ばれる点を見れば Composite と言えなくもない
