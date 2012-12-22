# -*- coding: utf-8 -*-
class Random
  def next
    rand(7)
  end
end

class RedOnly
  def next
    6
  end
end

# テトリミノのツモはダイス次第
class Player
  def initialize(dice)
    @dice = dice
  end
  def run
    7.times.collect{@dice.next}
  end
end

Player.new(Random.new).run  # => [3, 1, 4, 1, 2, 3, 6]
Player.new(RedOnly.new).run # => [6, 6, 6, 6, 6, 6, 6]

# RandomやRedOnlyを作るのが面倒→クラスの爆発
# これを解消するには→コードブロックを使ったストラテジー
class Player2
  def initialize(&dice)
    @dice = dice
  end
  def run
    7.times.collect{@dice.call}
  end
end

Player2.new{rand(7)}.run  # => [2, 5, 5, 6, 6, 2, 0]
Player2.new{6}.run        # => [6, 6, 6, 6, 6, 6, 6]
