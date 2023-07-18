## Template Method ##

#+BEGIN_SRC
class Base
  def run
    a + b
  end
end

class App < Base
  def a
    1
  end

  def b
    2
  end
end

App.new.run # => 3
#+END_SRC

# * 差分プログラミング最高
#   * 綺麗に決まると気持ちよい
#   * OAOO原則と相性が良い
# * 指定のメソッドだけ埋めればいいとはいえスーパークラスの意向を正確に把握しておかないといけない場合も多い
# * 神クラス化に注意
#   * 多用しているとグローバル空間に大量のメソッドがあるのと変わらない状況になってくるので注意
#   * 単にオプション引数を工夫するとかコンポジション構造にする方が適している場合もある
# * これも？
#   * initialize メソッドも書けば最初に呼ばれると決まっているので Templete Method と言えなくもない
#   * Arduino だと setup と loop 関数を書けばいい感じに呼ばれるようになっている
#   * C の main 関数も広義の Templete Method か？

