# シンプルなDSL

class Expression
end

class Value < Expression
  def initialize(value)
    @value = value
  end
  def evaluate
    @value
  end
end

class Add < Expression
  def initialize(left, right)
    @left, @right = left, right
  end
  def evaluate
    @left.evaluate + @right.evaluate
  end
end

def A(l, r)
  Add.new(Value.new(l), Value.new(r))
end

expr = A 1, 2
expr.evaluate # => 3
