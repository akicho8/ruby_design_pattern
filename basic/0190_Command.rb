## Command ##

#+BEGIN_SRC
commands = []
commands << -> { 1 }
commands << -> { 2 }
commands.collect(&:call)        # => [1, 2]
#+END_SRC

# * Rails の Migration のような仕組みもそう
# * perform, call, run, evaluate, execute のようなメソッドがよく使われる
#   * 一つのクラスで混在させてはいけない
# * 逆にそのメソッドがあれば Command パターンだと推測できる
# * Ruby なら call で統一すると一貫性が保てる
#   * Proc や lambda に置き換えれる

