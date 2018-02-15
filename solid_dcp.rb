# 【O】Open-Closed Principle - オープン・クローズドの原則
# Open  - 拡張しやすい
# Close - 拡張しても元のコードに影響がない

class C
  def initialize(type)
    @type = type
  end

  def f(v)                      # ここがどんどん肥大化する可能性あり
    if @type == 0
      "[#{v}]"
    else
      "(#{v})"
    end
  end
end

C.new(0).f("x")                 # => "[x]"

# 改善

class C2
  def initialize(obj)
    @obj = obj
  end

  def f(v)
    @obj.format(v)
  end
end

class A
  def format(v)
    "[#{v}]"
  end
end

C2.new(A.new).f("x")            # => "[x]"
