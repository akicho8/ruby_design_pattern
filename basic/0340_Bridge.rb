## Bridge ##

# Aが2個でBが2個なので継承を重ねると組み合わせは 2 * 2 で4パターンになる
# もしAが10個でBが10個なら100パターンになって破綻する

#+BEGIN_SRC
class A; end

class A1 < A; end
class A2 < A; end

class A1_B1 < A1; end
class A1_B2 < A1; end
class A2_B1 < A2; end
class A2_B2 < A2; end

A1_B1.new                       # => #<A1_B1:0x000000010350e750>
#+END_SRC

# 改善後

#+BEGIN_SRC
class A
end

class A1 < A; end
class A2 < A; end

class B
  def initialize(a)
    @a = a
  end
end

class B1 < B; end
class B2 < B; end

B1.new(A1.new)                  # => #<B1:0x000000010350e020 @a=#<A1:0x000000010350e098>>
#+END_SRC

# これなら組み合わせ爆発しない
# Aシリーズと、Bシリーズを個々に作るだけ
# 普通にあるようなコードなのでどこが Bridge なのかはよくわかってない
