## Mediator ##

#+BEGIN_SRC
class Mediator
  attr_reader :a, :b

  def initialize
    @a = A.new(self)
    @b = B.new(self)
  end

  def changed
    @b.visible = @a.state
  end
end

class A
  attr_accessor :state

  def initialize(mediator)
    @mediator = mediator
    @state = true
  end

  def changed
    @mediator.changed
  end
end

class B
  attr_accessor :visible
  def initialize(mediator)
    @mediator = mediator
  end
end

m = Mediator.new
m.a.state = true
m.a.changed
m.b.visible # => true
#+END_SRC

# * 特徴
#   * A と B は互いのことを知らない
#   * A は変更したことを B ではなく Mediator に伝える
#   * C ができたとしても A の挙動は変わらない
# * メリット
#   * 関連オブジェクトへの調整を一箇所で行える
#   * 疎結合化
# * デメリット
#   * Mediator がいい感じに存在してくれるせいでなんでも屋になってしまう
#   * 間違って適用すると疎結合にしたことで逆に扱いにくくなる場合がある
