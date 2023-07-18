## Singleton ##

#+BEGIN_SRC
class C
  private_class_method :new

  def self.instance
    @instance ||= new
  end
end

C.instance # => #<C:0x0000000105b8def8>
C.instance # => #<C:0x0000000105b8def8>
#+END_SRC

# 標準ライブラリを使った場合

#+BEGIN_SRC
require "singleton"

class C
  include Singleton
end

C.instance # => #<C:0x0000000105b8def8>
C.instance # => #<C:0x0000000105b8def8>
#+END_SRC

#+oneline: true
# どちらにしろ instance って書かないといけないのがちょっと面倒だったりする。
# でもあとでやっぱりグローバル変数にするのやめたいってなったとき instance を new に置換するだけでいいのは楽そう。

# instance って書くのがやっぱり面倒なときは割り切って次のように書いてもいい

#+BEGIN_SRC
module Config
  class << self
    attr_accessor :foo
  end
end

Config.foo # => nil
#+END_SRC

# または

#+BEGIN_SRC
require "active_support/core_ext/module/attribute_accessors"

module Config
  mattr_accessor :foo
end

Config.foo # => nil
#+END_SRC
