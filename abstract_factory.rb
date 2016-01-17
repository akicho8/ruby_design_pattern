# Abstract Factory - 関連する部品を組み合わせて部品を作る

class A
end

class C
  attr_accessor :list
end

c = C.new
c.list = [A.new]

# だと A と間違えて B を使うかもしれないので

class C
  def create_x
    A.new
  end
end

# としとけば

c = C.new
x = c.create_x
c.list = [x]

# となって間違いがない…ということなのかよくわかってない

# 別の例

class C
  def run # !> previous definition of run was here
    A.new + B.new
  end
end

class C
  def run # !> method redefined; discarding old run
    @factory.new_x + @factory.new_y
  end
end

# 実践例

# Builder#build では10個ぐらいのクラスを使ってあれこれする
# 最初は A.new("x") と書けばいいけど、別の挙動になって欲しいときは
# 「Aクラス」と、ハードコーディングされていることが問題になってくる
# そこで FactorySet1 などで「Aクラスの」部分を動的にする
# 動的にするのが目的なので方法はなんでもいいはず。
# ruby なら A 自体を引数で渡せばいいし。
# Java だとそういうことはできないから new_a のなかで A.new を呼ぶことになってるはず。

class Builder
  def initialize(factory)
    @factory = factory
  end
  def build
    @factory.new_a("x").build
  end
end

class A
  def initialize(value)
    @value = value
  end
  def build
    "(#{@value})"
  end
end

class FactorySet1
  def new_a(*args)
    A.new(*args)
  end
end

class B
  def initialize(value)
    @value = value
  end
  def build
    "<#{@value}>"
  end
end

class FactorySet2
  def new_a(*args)
    B.new(*args)
  end
end

Builder.new(FactorySet1.new).build # => "(x)"
Builder.new(FactorySet2.new).build # => "<x>"
