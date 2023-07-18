## Decorator ##

# Proxy に似ているけど遅延実行や実行条件には関心がない

#+BEGIN_SRC
require "delegate"

class User
  def name
    "alice"
  end
end

class UserDecorator < SimpleDelegator
  def call_name
    "#{name}さん"
  end
end

UserDecorator.new(User.new).call_name # => "aliceさん"
#+END_SRC

# * モデルが肥大化してもなんら問題ないので基本使わない
# * 使うとしても委譲して公表しない
# * モデルと Decorator の関係が1対1ならメリットは少ないしデメリットと相殺する
# * 1対多なら挙動を切り替える目的で便利かもしれないがそれは Decorator とは呼べない

