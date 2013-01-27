# -*- coding: utf-8 -*-

class C
  def f1
    "x"
  end
end

# 継承版

class C2 < C
  def f2
    f1 * 2
  end
end

# 委譲版

class C3
  def initialize
    @c = C.new
  end

  def f1
    @c.f1
  end

  def f2
    f1 * 2
  end
end

# 委譲版 (その2)

require "delegate"

class C4 < SimpleDelegator
  def initialize
    super(C.new)
  end

  def f2
    f1 * 2
  end
end

[C2.new.f1, C2.new.f2]      # => ["x", "xx"]
[C3.new.f1, C3.new.f2]      # => ["x", "xx"]
[C4.new.f1, C4.new.f2]      # => ["x", "xx"]
