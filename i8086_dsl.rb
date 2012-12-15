# -*- coding: utf-8 -*-
# アセンブラのコードを吐くDSL

class Expression
end

class Value < Expression
  attr_accessor :value
  def initialize(value)
    @value = value
  end
  def evaluate
    ["mov  ax, #{@value}"]
  end
end

class Add < Expression
  def initialize(left, right)
    @left, @right = left, right
  end
  def evaluate
    code = []
    code << @left.evaluate
    code << "mov  dx, ax"
    code << @right.evaluate
    code << "add  ax, dx"
  end
end

def A(l, r)
  Add.new(Value.new(l), Value.new(r))
end

expr = A 1, 2
puts expr.evaluate
# >> mov  ax, 1
# >> mov  dx, ax
# >> mov  ax, 2
# >> add  ax, dx
