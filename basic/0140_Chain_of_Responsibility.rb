## Chain of Responsibility ##

#+BEGIN_SRC
class Chainable
  def initialize(next_chain = nil)
    @next_chain = next_chain
  end

  def support(q)
    if resolve?(q)
      answer(q)
    elsif @next_chain
      @next_chain.support(q)
    else
      "?"
    end
  end
end

class Alice < Chainable
  def resolve?(q)
    q == "1+2"
  end

  def answer(q)
    "3"
  end
end

class Bob < Chainable
  def resolve?(q)
    q == "2*3"
  end

  def answer(q)
    "6"
  end
end

alice = Alice.new(Bob.new)
alice.support("1+2") # => "3"
alice.support("2*3") # => "6"
alice.support("2/1") # => "?"
#+END_SRC

# * A は B を持ち、B は C を……な構造は本当に必要なんだろうか？
#   * `A.new(B.new(C.new(D.new(E.new))))`  になってしまう
# * 単に `[A, B, C, D, E]` と並べて上から順に反応したやつを実行じゃだめ？
