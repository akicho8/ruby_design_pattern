## Observer ##

# Subject からの一方通行でないといけない
# たまに戻値が欲しくなる場合があるけど、それはもう Observer ではなくなっている
# Observer 側に Subject (player) を渡して player.add_observer(self) は、まわりくどいので自分はやらない
# Observer に player を握らせたら Component Bus パターンになるらしい

#+BEGIN_SRC
class Foo
  def update(object)
  end
end

class Bar
  def update(object)
  end
end

class Player
  def initialize
    @foo = Foo.new
    @bar = Bar.new
  end

  def notify
    if @foo
      @foo.update(self)
    end
    if @bar
      @bar.update(self)
    end
  end
end
#+END_SRC

# 上の密結合状態を解消する

#+BEGIN_SRC
class Player
  attr_accessor :observers

  def initialize
    @observers = []
  end

  def notify
    @observers.each do |observer|
      observer.update(self)
    end
  end
end

player = Player.new
player.observers << Foo.new
player.observers << Bar.new
player.notify
#+END_SRC

# 標準ライブラリを使うとより簡潔になる

#+BEGIN_SRC
require "observer"

class Player
  include Observable

  def notify
    changed
    notify_observers(self)
  end
end

player = Player.new
player.add_observer(Foo.new)
player.add_observer(Bar.new)
player.notify
#+END_SRC

# 自分をオブザーバーにしてもいい

#+BEGIN_SRC
require "observer"

class Player
  include Observable

  def initialize
    add_observer(self)
  end

  def notify
    changed
    notify_observers(self)
  end

  def update(player)
    player # => #<Player:0x00000001079e9960 @observer_peers={#<Player:0x00000001079e9960 ...>=>:update}, @observer_state=true>
  end
end

player = Player.new
player.notify
#+END_SRC

# これを「ぼっちObserverパターン」と勝手に呼んでいる
