# The Dependency Inversion Principle: 依存関係逆転の原則

# Printer が F1 や F2 に依存しているのが問題

class F1
  def format(s)
    "[#{s}]"
  end
end

class F2
  def format(s)
    "(#{s})"
  end
end

class Printer
  def initialize(s)
    @s = s
  end

  def print_f1
    F1.new.format(@s)
  end

  def print_f2
    F2.new.format(@s)
  end
end

Printer.new("x").print_f1       # => "[x]"
Printer.new("x").print_f2       # => "(x)"

# ↓

class Printer
  def initialize(s)
    @s = s
  end

  def print(formatter: F1.new)
    formatter.format(@s)
  end
end

Printer.new("x").print(formatter: F1.new) # => "[x]"
Printer.new("x").print(formatter: F2.new) # => "(x)"
