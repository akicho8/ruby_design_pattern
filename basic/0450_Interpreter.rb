## Interpreter ##

# シンプルなDSL

#+BEGIN_SRC
class Expression
end

class Value < Expression
  attr_accessor :value
  def initialize(value)
    @value = value
  end

  def evaluate
    "mov  ax, #{@value}"
  end
end

class Add < Expression
  def initialize(left, right)
    @left, @right = left, right
  end

  def evaluate
    [
      @left.evaluate,
      "mov  dx, ax",
      @right.evaluate,
      "add  ax, dx",
    ]
  end
end

def ADD(l, r)
  Add.new(Value.new(l), Value.new(r))
end

expr = ADD 1, 2
puts expr.evaluate
#+END_SRC

# ```:Output
# mov  ax, 1
# mov  dx, ax
# mov  ax, 2
# add  ax, dx
# ```
