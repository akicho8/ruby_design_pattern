## First Class Collection ##

#+BEGIN_SRC
class Group
  include Enumerable

  def initialize(items)
    @items = items
  end

  def each(...)
    @items.each(...)
  end
end

Group.new([5, 6, 7]).collect(&:itself) # => [5, 6, 7]
#+END_SRC

# * 特徴
#   * 配列をラップする
#   * Value Object と考え方は同じ
#   * Immutable にすべきとは決まっているわけじゃないけど Immutable にした方がいい
# * 特定の配列に対する処理があまりにも複雑かつ散乱する場合に使う
# * Ruby なら each を定義しとこう
# * 面倒なので `class Group < Array; end` とすることが多い
