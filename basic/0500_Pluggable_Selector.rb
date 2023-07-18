## Pluggable Selector ##

#+BEGIN_SRC
class C
  def run(type)
    send("command_#{type}")
  end

  def command_a
  end

  def command_b
  end
end

C.new.run(:a)                   # => nil
#+END_SRC

# * 特徴
#   * 動的に自分のメソッドを呼ぶ
#   * SOLID の S こと「単一責任」から見ればアンチパターン(？)
#   * Composed Method のつもりでいればそんな問題はない
# * メリット
#   * クラス爆発を抑えられる
# * デメリット
#   * クラスが悪い方向に肥大化しかねない
#   * command_a を grep してもどこから呼ばれているかわからない
#     * Ruby だとそんなのはしょっちゅう
# * 注意点
#   * ユーザー入力を元にする場合、プレフィクスなどを付けておかないと、すべてのメソッドが呼び放題になる

