# Chain Of Responsibility
# ・各オブジェクトは resolve? で処理可能かどうかまず返答する
# ・処理できるなら対応
# ・処理できなければ次のやつに伺う

class Chainable
  def initialize(_next = nil)
    @_next = _next
  end
  def support(q)
    if resolve?(q)
      answer(q)
    elsif @_next
      @_next.support(q)
    else
      "知らん"
    end
  end
end

class Alice < Chainable
  def resolve?(q)
    q == "1+2は？"
  end
  def answer(q)
    "3"
  end
end

class Bob < Chainable
  def resolve?(q)
    q == "2*3は？"
  end
  def answer(q)
    "6"
  end
end

alice = Alice.new(Bob.new)
alice.support("1+2は？") # => "3"
alice.support("2*3は？") # => "6"
alice.support("2/1は？") # => "知らん"
