## Strategy ##

#+BEGIN_SRC
class LegalDice
  def next
    rand(1..6)
  end
end

class CheatDice
  def next
    6
  end
end

class Player
  def initialize(dice)
    @dice = dice
  end

  def roll
    3.times.collect { @dice.next }
  end
end

Player.new(LegalDice.new).roll  # => [6, 4, 3]
Player.new(CheatDice.new).roll  # => [6, 6, 6]
#+END_SRC

# * Player のコードはそのままでサイコロのアルゴリズムを切り替える
# * 利用者は LegalDice や CheatDice を知っている
# * State と似ているが内部で切り替えるのではなく利用者が外から渡す
#   * そういう意味では意図せず引数が Strategy になっていたりする
# * 上の例は大袈裟
#   * Ruby ならコードブロックでいい

