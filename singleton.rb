class C
  private_class_method :new
  def self.instance
    @instance ||= new
  end
end

C.instance # => #<C:0x007f98e404a518>
C.instance # => #<C:0x007f98e404a518>

require "singleton"
class S
  include Singleton
end
S.instance # => #<S:0x007f98e509f558>
S.instance # => #<S:0x007f98e509f558>
