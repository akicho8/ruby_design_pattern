# -*- coding: utf-8 -*-
# http://www002.upp.so-net.ne.jp/ys_oota/mdp/ComponentBus/
require "observer"

class Player
  include Observable
  attr_accessor :data
  def notify
    changed
    notify_observers
  end
end

class Display
  def initialize(player)
    player.add_observer(self)
    @player = player
  end
  def update
  end
  def data
    @player.data
  end
end

player = Player.new
display = Display.new(player)
player.notify
