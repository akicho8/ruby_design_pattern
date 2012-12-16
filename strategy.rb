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

Player.new(Random.new).run  # => [1, 5, 4, 1, 0, 0, 6]
Player.new(RedOnly.new).run # => [6, 6, 6, 6, 6, 6, 6]
