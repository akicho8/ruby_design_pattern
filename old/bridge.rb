# Bridge - 機能の階層と実装の階層を分ける

# x y が実装で () で囲みたいというのを機能ということにすれば AA を作った時点で BB は不要
# 要はDRYじゃないってこと

class A
  def run
    "x"
  end
end

class B
  def run
    "y"
  end
end

class AA < A
  def run
    "(x)"
  end
end

class BB < B
  def run
    "(y)"
  end
end

# 改善

class A
  def initialize(obj)
    @obj = obj
  end

  def run
    @obj
  end
end

class AA < A
  def run
    "(#{@obj})"
  end
end
