# -*- coding: utf-8 -*-

class A
  attr_accessor :state
  def initialize(b)
    @b = b
    @state = true
  end
  def changed
    @b.visible = @state
  end
end

class B
  attr_accessor :visible
end

# 改善

# A と B に Mediator のインスタンスを持たせて changed は Mediator のインスタンスに投げる

class Mediator
  attr_reader :a, :b
  def initialize
    @a = A.new(self)
    @b = B.new(self)
  end
  def changed
    @b.visible = @a.state
  end
end

class A
  attr_accessor :state
  def initialize(mediator)
    @mediator = mediator
    @state = true
  end
  def changed
    @mediator.changed
  end
end

class B
  attr_accessor :visible
  def initialize(mediator)
    @mediator = mediator
  end
end

m = Mediator.new
m.a.state = true
m.a.changed
m.b.visible # => true
