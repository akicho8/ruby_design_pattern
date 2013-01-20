# -*- coding: utf-8 -*-
# Immutable - 壊したくとも壊せない
# セッターが存在しないクラスを Immutable と言う

$DEBUG = true

class User
  attr_reader :name, :password
  def initialize(name, password)
    @name = name
    @password = password
  end

  def to_s
    "[name=#{@name} password=#{@password}]"
  end

  def check
    @name[0] == @password[0]     # changeを有効にすると個々で nil[0] を実行してしまいエラーになる
  end

  def change
    a, b = @name, @password
    if true
      # @name, @password = nil, nil  # ここを有効にすると Immutable では無くなり check でエラーが出る
      sleep(0.1)
    end
    @name, @password = a, b
  end
end

# User が immutable であれば true を返す。
ary = []
user = User.new("alice", "a")
ary = 2.times.collect do
  Thread.start do
    2.times do
      user.change             # 危険
      user.check
    end
  end
end
ary.each(&:join)
