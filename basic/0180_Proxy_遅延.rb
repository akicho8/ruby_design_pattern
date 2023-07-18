### 遅延 (あとで呼ぶ) ###

#+BEGIN_SRC
class VirtualPrinter
  def name
    "初期化が遅いプリンタ"
  end

  def print(str)
    @printer ||= RealPrinter.new
    @printer.print(str)
  end
end

class RealPrinter
  def initialize
    p "とてつもなく時間がかかる初期化処理..."
  end

  def name
    "初期化が遅いプリンタ"
  end

  def print(str)
    str
  end
end

printer = VirtualPrinter.new
printer.name        # => "初期化が遅いプリンタ"
printer.print("ok") # => "ok"
#+END_SRC

#+hidden: true
# >> "とてつもなく時間がかかる初期化処理..."
