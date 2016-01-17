class C
  def f1
    "x"
  end
end

# 継承版

class C2 < C
  def f2
    f1 * 2
  end
end

# 委譲版

class C3
  def initialize
    @c = C.new
  end

  def f1
    @c.f1
  end

  def f2
    f1 * 2
  end
end

# 委譲版 (その2)

require "delegate"

class C4 < SimpleDelegator
  def initialize
    super(C.new)
  end

  def f2
    f1 * 2
  end
end

[C2.new.f1, C2.new.f2]      # => ["x", "xx"]
[C3.new.f1, C3.new.f2]      # => ["x", "xx"]
[C4.new.f1, C4.new.f2]      # => ["x", "xx"]

# --------------------------------------------------------------------------------

class User
  def self.search(query)
    ["name like ?", "%#{query}%"]
  end
end

User.search("alice")                     # => ["name like ?", "%alice%"]

class User
  def self.search(*args)
    UserSearch.new(self, *args).run
  end
end

class UserSearch
  def initialize(model, query)
    @model = model
    @query = query
  end
  def run
    ["name like ?", "%#{@query}%"]
  end
end

User.search("alice")   # => ["name like ?", "%alice%"]

class Player
  attr_accessor :color
  def initialize
    @color = :blue
  end
end

# ここでプレイヤーの色は青なので #00F が欲しいとする

# 動けばいい的なダメな方法

class Player
  def rgb
    if @color == :blue
      "#00F"
    end
  end
end

# 改善

class ColorInfo
  attr_accessor :color
  def initialize(color)
    @color = color
  end
  def rgb
    "#00F"
  end
end

class Player
  def color_info
    ColorInfo.new(@color)
  end
end

Player.new.rgb                       # => "#00F"
Player.new.color_info.rgb            # => "#00F"

# 綺麗な形で拡張できる

class ColorInfo
  def human_name
    "青"
  end
end

Player.new.color_info.human_name     # => "青"
