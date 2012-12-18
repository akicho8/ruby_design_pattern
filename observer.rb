# -*- coding: utf-8 -*-

class Paint
  def update(*args)
    p args
  end

  def method_missing(*args)
    p args
  end
end

class Network < Paint
end

# ダメな状態(密結合)
class Player
  def initialize
    @paint = Paint.new
    @network = Network.new
  end

  def notify
    if @paint
      @paint.font(0, 0, status)
    end
    if @network
      @network.post(status)
    end
  end
end

# 疎結合
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
player.observers << Paint.new
player.observers << Network.new

require "observer"
class Player
  include Observable
  def notify # !> previous definition of notify was here
    changed
    notify_observers(self)
  end
end

player = Player.new
player.add_observer(Paint.new)
player.add_observer(Network.new)
player.notify

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
    player                      # => #<Player:0x007ff9098472e0 ...>
  end
end

player = Player.new
player.notify
