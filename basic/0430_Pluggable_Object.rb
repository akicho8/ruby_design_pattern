## Pluggable Object ##

#+BEGIN_SRC
class A
  def initialize(x)
    if x
      @object = X.new
    else
      @object = Y.new
    end
  end

  def foo
    @object.foo
  end

  def bar
    @object.bar
  end
end
#+END_SRC

# * そっくりな State との見分け方
#   * State は3つ以上の状態があり、さらに増える可能性もあるときに使うパターンと考える
#   * Pluggable Object はもともと同じ条件のif文による二択が同一クラス内で散乱している状態をリファクタリングしてポルモルフィックにしたものと考える
#   * 状態を表わすかどうかで両者は分別できない
#     * State は状態を表わす
#     * 「テスト駆動開発」本の例だと Pluggable Object も(本意ではないかもしれないけど)状態を表している
# * 利用者には見えない形で使う
#   * これも State と同じ
#   * もし利用者が渡す形であればそれは Strategy になる

