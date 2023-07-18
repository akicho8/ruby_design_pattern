### 仮想 (まねる) ###

#+BEGIN_SRC
class VirtualPrinter
  def name
    "初期化が遅いプリンタ"
  end

  def print(str)
  end
end

printer = VirtualPrinter.new
printer.name        # => "初期化が遅いプリンタ"
printer.print("ok") # => nil
#+END_SRC
