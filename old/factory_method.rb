class X
end

class F
  def create
    X.new
  end
end

class C
  attr_accessor :v
  def initialize(f)
    @v = f.create
  end
end

C.new(F.new).v                  # => #<X:0x007fc8690862e8>
