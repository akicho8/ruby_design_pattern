## Abstract Factory ##

#+BEGIN_SRC
class X; end
class Y; end
class Z; end

group = { a: X, b: Y }

group[:a].new
group[:b].new
#+END_SRC

# * X と Y の組み合わせで作ればいいことが group 経由で保証される
#   * X と Y しか無いならやる意味がない
#   * X と Y の他に10個ぐらいあっても迷わないなら不要
#   * X と Y の他に100個ぐらいあって間違えるならやっと使うぐらいでいい
# * group で挙動が切り替わるという意味で言えば Strategy でもある
# * 柔軟性を封じる意味では CoC なところもある
