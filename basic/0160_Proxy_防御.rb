### 防御 (呼ぶか、呼ばないか) ###

#+BEGIN_SRC
require "active_support/core_ext/module/delegation"

class User
  attr_accessor :name, :score

  def initialize(name)
    @name = name
    @score = 0
  end
end

class UserProxy
  BLACK_LIST = ["alice"]

  delegate :score, to: :@user

  def initialize(user)
    @user = user
  end

  def method_missing(...)
    unless BLACK_LIST.include?(@user.name)
      @user.send(...)
    end
  end
end

user = User.new("alice")
user.score += 1
user.score                      # => 1

user = UserProxy.new(User.new("alice"))
user.score += 1
user.score                      # => 0
#+END_SRC

