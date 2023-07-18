## Value Object ##

#+BEGIN_SRC
class Vector
  def self.[](...)
    new(...)
  end

  attr_accessor :x, :y

  private_class_method :new

  def initialize(x, y)
    @x = x
    @y = y
    freeze
  end

  def +(other)
    self.class[x + other.x, y + other.y]
  end

  def inspect
    [x, y].to_s
  end
end

Vector[1, 2] + Vector[3, 4]     # => [4, 6]
#+END_SRC

# * Immutable な点が特徴
#   * initialize の最後で freeze するのがわかりやすい
#     * が、遅延実行時のメモ化ができなくなってはまることが多い
#     * その場合は initialize の中でメモ化に使う Hash インスタンスを freeze 前に用意しておいてそれをメモに使う
#     * 例えば `@memo = {}` を用意しておいて foo メソッド内で `@memo[:foo] ||= 1 + 2` などとすると怒られない
# * デザインパターンのなかでいちばん効果がある
#   * ただの Integer や String な変数であっても、それをあちこちで引数に取る処理があったとすれば、方向を逆にできないか考える
#   * とりあえず動いたからOKの考えでは、逆にする発想が思い浮かばなくなっていく
#   * なので引数がくる度に頭の中で逆にしてみる癖をつける
# * 例外として何を犠牲にしてでも処理速度を優先させたいところでは使わない方がいい
# * Value Object に似ているけど Mutable で、識別子が同じであれば同一視するようなものは Entity というらしい
#   * 例えば ActiveRecord のインスタンス
# * 四則演算子の他に `<=>` `==` `eql?` `hash` や `to_s` `inspect` をいい感じに定義しておくと使いやすくなる

#+BEGIN_SRC
class Foo
  attr_accessor :my_value

  class << self
    def [](...)
      wrap(...)
    end

    def wrap(my_value)
      if self === my_value
        return my_value
      end
      new(my_value)
    end
  end

  private_class_method :new

  def initialize(my_value)
    @my_value = my_value
    freeze
  end

  def <=>(other)
    [self.class, my_value] <=> [other.class, other.my_value]
  end

  def ==(other)
    self.class == other.class && my_value == other.my_value
  end

  def eql?(other)
    self == other
  end

  def hash
    my_value.hash
  end

  def to_s
    my_value.to_s
  end

  def inspect
    "<#{self}>"
  end
end

Foo["a"] == Foo["a"]                          # => true
[Foo["a"], Foo["b"], Foo["c"]] - [Foo["b"]]   # => [<a>, <c>]
[Foo["b"], Foo["c"], Foo["a"]].sort           # => [<a>, <b>, <c>]
#+END_SRC
