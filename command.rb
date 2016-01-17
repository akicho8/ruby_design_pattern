# Strategy は結果に関心がある
# Observer は呼び出し元に関心がある
# Command は呼び出し元も関心がなければ、結果にも関心がない(？)

class Command
end

class FooCommand < Command
  def execute
    "a"
  end
end

class BarCommand < Command
  def execute
    "b"
  end
end

class CompositeCommand < Command
  def initialize
    @commands = []
  end
  def <<(command)
    @commands << command
  end
  def execute
    @commands.collect(&:execute)
  end
end

command = CompositeCommand.new
command << FooCommand.new
command << BarCommand.new

command.execute                 # => ["a", "b"]

class BazCommand < Command
  def initialize(&block)
    @command = block
  end
  def execute
    @command.call
  end
end

command << BazCommand.new {"c"}
command << BazCommand.new {"d"}

command.execute                 # => ["a", "b", "c", "d"]
