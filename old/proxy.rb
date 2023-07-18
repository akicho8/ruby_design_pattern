class User
  attr_accessor :name, :point
  def initialize(name)
    @name = name
    @point = 0
  end
  def deposit(amount)
    @point += amount
  end
end

# ガードプロキシ(呼んだり、呼ばなかったり)

class UserProxy
  BlackList = ["alice"]

  def initialize(user)
    @user = user
  end

  def point
    @user.point
  end

  def method_missing(*args)
    if BlackList.include?(@user.name)
      return
    end
    @user.send(*args)
  end
end

user = User.new("alice")
user.deposit(1)
user.point                      # => 1

user = UserProxy.new(User.new("alice"))
user.deposit(1)
user.point                      # => 0

# 仮想プロキシ(まねる)

class VirtualPrinter
  def name
    "BJ10V"
  end
  def print(str)
  end
end

# 遅延実行(あとで呼ぶ)

class VirtualPrinter
  def name
    "BJ10V"
  end
  def print(str)
    @printer ||= RealPrinter.new
    @printer.print(str)
  end
end

class RealPrinter
  def initialize
    puts "とてつもなく時間がかかる初期化処理..."
  end
  def name
    "BJ10V"
  end
  def print(str)
    str
  end
end

printer = VirtualPrinter.new
printer.name        # => "BJ10V"
printer.print("ok") # => "ok"
# >> とてつもなく時間がかかる初期化処理...
