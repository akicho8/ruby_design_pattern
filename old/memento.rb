class Player
  attr_accessor :cards

  def initialize
    @cards = []
  end

  def take
    @cards << rand(1..13)
  end

  def score
    @cards.reduce(&:+)
  end
end

3.times do
  player = Player.new
  5.times do
    player.take
  end
  player.score                  # => 33, 37, 52
end

class Player
  def create_memento
    @cards.clone
  end

  def restore_memento(object)
    @cards = object.clone
  end
end

3.times do
  player = Player.new
  memento = nil
  5.times do
    player.take
    if player.score < 21
      memento = player.create_memento
    elsif player.score > 21
      player.restore_memento(memento)
    end
  end
  player.score                  # => 18, 19, 15
end
