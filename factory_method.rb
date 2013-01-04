# -*- coding: utf-8 -*-

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
