## Memento ##

# ブラックジャックを行うプレイヤーがいるとする

#+BEGIN_SRC
class Player
  attr_accessor :cards

  def initialize
    @cards = []
  end

  def take
    @cards << rand(1..13)
  end

  def score
    @cards.sum
  end
end
#+END_SRC

# 5回カードを引くゲームを3回行うと全部21を越えてしまった

#+BEGIN_SRC
3.times do
  player = Player.new
  5.times { player.take }
  player.score                  # => 33, 45, 28
end
#+END_SRC

# そこで Memento パターンを使う

#+BEGIN_SRC
class Player
  def create_memento
    @cards.clone
  end

  def restore_memento(object)
    @cards = object.clone
  end
end
#+END_SRC

# 21点未満の状態を保持しておき21を越えたら元に戻す

#+BEGIN_SRC
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
  player.score                  # => 20, 20, 19
end
#+END_SRC

# memento には復元に必要なものだけ入れとく
