## Marker Interface ##

# * 種類で判別するためにモジュールを入れる
# * これは Java ならではな感じはする
# * ダックタイピングな言語ではやらない
# * とはいえ以前ベクトルの定義で「普通のベクトル」と「繰り返すことができるベクトル」をクラスで判別したくて次のように書いた。これはある種 Marker Class と言えるのかもしれない。

#+BEGIN_SRC
require "matrix"

class RepeatableVector < Vector; end
class SingleVector < Vector; end

RepeatableVector[1, 1]          # => Vector[1, 1]
SingleVector[1, 1]              # => Vector[1, 1]
#+END_SRC
