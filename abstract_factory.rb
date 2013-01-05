# -*- coding: utf-8 -*-
# Abstract Factory - 関連する部品を組み合わせて部品を作る

class A
end

class C
  attr_accessor :list
end

c = C.new
c.list = [A.new]

# だと A と間違えて B を使うかもしれないので

class C
  def create_x
    A.new
  end
end

# としとけば

c = C.new
x = c.create_x
c.list = [x]

# となって間違いがない…ということなのかよくわかってない

# 別の例

class C
  def run
    A.new + B.new
  end
end

class C
  def run
    @factory.new_x + @factory.new_y
  end
end
