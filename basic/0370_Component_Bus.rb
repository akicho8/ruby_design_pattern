## Component Bus ##

# Observer たちがデータ共有したいので Subject を共有することにしたパターン

#+BEGIN_SRC
require "observer"

class Player
  include Observable

  attr_accessor :xxx

  def notify
    changed
    notify_observers
  end
end

class Display
  def initialize(player)
    player.add_observer(self)
    @player = player    # Subjectを握っている
  end

  def update
  end

  def xxx
    @player.xxx
  end
end
#+END_SRC

# 一方通行だった Observer が Subject 依存してしまうデメリットも考慮すること
