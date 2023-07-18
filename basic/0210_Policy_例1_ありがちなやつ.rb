### 例1. ありがちなやつ ###

#+BEGIN_SRC
require "active_support/core_ext/module/delegation"

class User
  attr_accessor :name

  delegate :editable?, to: :policy

  def initialize(name)
    @name = name
  end

  def policy
    UserPolicy.new(self)
  end
end

class UserPolicy
  def initialize(user)
    @user = user
  end

  def editable?
    @user.name == "alice"
  end
end

User.new("alice").editable?        # => true
User.new("bob").editable?          # => false
#+END_SRC

# 関心事「権限」で分離したいときに使う
