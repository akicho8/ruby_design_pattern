## Abstract Class ##

#+BEGIN_SRC
class Player
  def play
    raise NotImplementedError, "#{__method__} is not implemented"
  end
end

class MusicPlayer < Player
  def play
  end
end

class VideoPlayer < Player
  def play
  end
end

players = []
players << MusicPlayer.new
players << VideoPlayer.new
players.each(&:play)
#+END_SRC

# * Java ならではの仰々しいパターンと言える
#   * こうしないと同じ配列に入れられないから
# * Ruby なら何もしてない Player クラスはいらない

