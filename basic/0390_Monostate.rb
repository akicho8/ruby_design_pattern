## Monostate ##

#+BEGIN_SRC
require "active_support/core_ext/module/attribute_accessors"

class C
  cattr_accessor :foo
end

a = C.new
b = C.new
a.foo = 1
b.foo                           # => 1
C.new.foo                       # => 1
#+END_SRC

# * instance ではなく new と書く
# * 結果として見れば Singleton だけど外からは Singleton のようには見えない
# * 実装者本人ですら騙される恐れあり

