## Sharable ##

#+BEGIN_SRC
class Color
  class << self
    def create(name, ...)
      @create ||= {}
      @create[name] ||= new(name, ...)
    end
  end

  attr_accessor :name, :lightness

  def initialize(name)
    @name = name
  end
end

color = Color.create(:white)
color.lightness = 1.0

Color.create(:white).lightness  # => 1.0
#+END_SRC

# * コードだけ見れば Flyweight と変わらない
# * データの一貫性を保つのが目的であれば Sharable になる
# * Mutable なのが特徴

