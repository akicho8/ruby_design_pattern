### 例2. Command パターンを活用する ###

#+BEGIN_SRC
class PositiveRule
  def valid?(value)
    value.positive?
  end
end

class EvenRule
  def valid?(value)
    value.even?
  end
end

rules = []
rules << PositiveRule.new
rules << EvenRule.new
rules.all? { |e| e.valid?(2) } # => true
#+END_SRC

# * 複雑な条件の組み合わせを Command パターンでほぐせる
# * ActiveRecord の Validator もこれ
# * 単に成功/失敗ではなく、あとからエラーメッセージも構築したいとなったときも分離しているとやりやすい
# * メソッドに引数を渡すのではなくインスタンス生成時に渡してもいい
