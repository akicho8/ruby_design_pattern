# Pluggable Selector

class C
  def initialize(command)
    @command = command
  end

  def execute
    send(@command)
  end

  def command_x
    :a
  end
end

C.new(:command_x).execute       # => :a
