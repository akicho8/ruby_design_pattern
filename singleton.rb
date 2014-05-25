class C
  private_class_method :new
  def self.instance
    @instance ||= new
  end
end

C.instance # => #<C:0x007fd6f0a5e938>
C.instance # => #<C:0x007fd6f0a5e938>

require "singleton"
class S
  include Singleton
end
S.instance # => #<S:0x007fd6f0a650d0>
S.instance # => #<S:0x007fd6f0a650d0>

module M
  extend self
  @data = {}
  def func
  end
end
