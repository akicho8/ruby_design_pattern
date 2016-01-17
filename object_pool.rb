# Object pool

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
    x = @pool.find {|e|!e.active}
    unless x
      if @pool.size < @size
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
a = i.new_x                  # => #<X:0x007fd1cb08d5c8 @active=true>
b = i.new_x                  # => #<X:0x007fd1cb08d140 @active=true>
c = i.new_x                  # => nil
a.active = false
c = i.new_x                  # => #<X:0x007fd1cb08d5c8 @active=true>
