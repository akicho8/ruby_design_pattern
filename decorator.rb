# -*- coding: utf-8 -*-
class User
  def name
    "alice"
  end
end

class UserDecorator2
  def initialize(object)
    @object = object
  end
  def to_xxx
    "(#{@object.name})"
  end
end

UserDecorator2.new(User.new).to_xxx # => "(alice)"

require "delegate"
class UserDecorator3 < SimpleDelegator
  def to_xxx
    "(#{name})"
  end
end

UserDecorator3.new(User.new).to_xxx # => "(alice)"

class UserDecorator4 < User
  def to_xxx
    "(#{name})"
  end
end

UserDecorator4.new.to_xxx           # => "(alice)"

require "delegate"
class UserDecorator5 < DelegateClass(User)
  def initialize
    super(User.new)
  end
  def to_xxx
    "(#{name})"
  end
end

UserDecorator5.new.to_xxx           # => "(alice)"
