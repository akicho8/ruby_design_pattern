# SRP - Single Responsibility Principle 単一責任 1つのクラスに複数の機能

# C1 には2つの機能がある。これがよくない。

class C
  def f1
    "機能1"
  end

  def f2
    "機能2"
  end
end

o = C.new
o.f1                            # => "機能1"
o.f2                            # => "機能2"

# それぞれのクラスに分ける

class C1
  def f1
    "機能1"
  end
end

class C2
  def f2
    "機能2"
  end
end

C1.new.f1                       # => "機能1"
C2.new.f2                       # => "機能2"
