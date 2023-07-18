## Composed Method ##

#+BEGIN_SRC
class Item
  def validate
    methods.grep(/validate_/).each { |e| send(e) }
  end

  private

  def validate_length
  end

  def validate_range
  end

  def validate_uniq
  end
end
#+END_SRC

# * 巨大化したメソッドをいい感じに分割する
# * private にしとこう
# * リファクタリングの第一歩
# * 引数が多すぎるメソッドが量産されてしまうのは本末転倒な感がある
# * 引数が多すぎるメソッドだらけになりそうなら
#   * → 委譲する
#   * → 引数で渡すのではなくインスタンス変数にする

