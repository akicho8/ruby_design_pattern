## Hook Operation ##

#+BEGIN_SRC
class A
  def call
    # 何かする
    after_call
  end

  def after_call
  end
end

class B < A
  def after_call
    # call の処理の後で何かする
  end
end

B.new.call
#+END_SRC

# * Template Method にしないといけないわけじゃない
# * 方法はなんでもいい
# * 継承するなら super の前後で呼んでもいいけど、それは意図して用意した仕掛けではないので Hook Operation とは言いづらいかもしれない
