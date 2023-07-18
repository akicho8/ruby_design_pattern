## Adapter ##

#+BEGIN_SRC
require "matrix"

vector = Vector[2, 3]
vector[0]          # => 2
vector[1]          # => 3

class Vec2 < Vector
  def x
    self[0]
  end

  def y
    self[1]
  end
end

vector = Vec2[2, 3]
vector.x           # => 2
vector.y           # => 3
#+END_SRC

# * 他にも方法はいろいろある
#   * 委譲する
#   * オブジェクト自体に特異メソッドを生やす
#   * Vector クラス側にメソッドを生やす
# * 委譲する場合 Proxy や Decorator と似たコードになる
# * が、重要なのはコードではなく意図

# > 不適切なインターフェイスを伴う痛みがシステム中に広がることを防ぎたい場合に限りアダプタを選んでください
# > ── Rubyによるデザインパターン P.155 より

