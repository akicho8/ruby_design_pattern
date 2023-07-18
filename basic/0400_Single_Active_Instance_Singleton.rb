## Single-Active-Instance Singleton ##

#+BEGIN_SRC
require "active_support/core_ext/module/attribute_accessors"

class Point
  cattr_accessor :current

  def self.run
    current&.name
  end

  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def activate!
    self.current = self
  end
end

a = Point.new("a")
b = Point.new("b")
Point.run                      # => nil
a.activate!
Point.run                      # => "a"
b.activate!
Point.run                      # => "b"
#+END_SRC

# * 複数あるインスタンスのなかで一つだけが有効になる
# * 画面上にマウスで動かせる点が複数があってその一つを選択するようなときに使う(たぶん)

