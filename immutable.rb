# -*- coding: utf-8 -*-
# Immutable - メンバー変数が変更されないからどこからアクセスしても安全という意味

class C
  attr_reader :v
  def initialize(v)
    @v = v
    @v.freeze
  end
end

a = C.new("x")
a.v.replace("y") rescue $! # => #<RuntimeError: can't modify frozen String>
a.v += "y" rescue $!       # => #<NoMethodError: undefined method `v=' for #<C:0x007fb7d2885338 @v="x">>
