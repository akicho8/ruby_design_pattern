## Object Pool ##

# メモ化というよりメモリと速度のトレードオフ

#+BEGIN_SRC
class X
  attr_accessor :active
end

class C
  attr_accessor :pool

  def initialize
    @size = 2
    @pool = []
  end

  def new_x
    x = @pool.find { |e| !e.active }  # pool から稼働してないものを探す
    unless x                          # なければ
      if @pool.size < @size           # pool の空きがあれば、新たに作成
        x = X.new
        @pool << x
      end
    end
    if x
      x.active = true
    end
    x
  end
end

i = C.new
a = i.new_x                  # => #<X:0x0000000105c1e390 @active=true>
b = i.new_x                  # => #<X:0x0000000105c1dd78 @active=true>
c = i.new_x                  # => nil
a.active = false
c = i.new_x                  # => #<X:0x0000000105c1e390 @active=true>
#+END_SRC
