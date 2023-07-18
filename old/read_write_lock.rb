# Read-Write Lock - read中はwrite禁止

require "sync"

class Buffer
  def initialize
    @sync = Sync.new
    @str = ""
  end

  def write(_str)
    @sync.synchronize(:EX) do
      _str.chars.with_index do |c, i|
        sleep(0.0001)
        @str[i] = c
      end
    end
  end

  def read
    @sync.synchronize(:SH) do
      @str.size.times.collect {|i|
        sleep(0.001)
        @str[i]
      }.join
    end
  end
end

buffer = Buffer.new
w = Thread.start do
  ("A".."Z").cycle {|c|
    buffer.write(c.to_s * 64)
    sleep(0.001)
  }
end
r = Thread.start do
  10.times do
    sleep(0.001)
    p buffer.read
  end
end
r.join
w.kill
# >> "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
# >> "BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB"
# >> "CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC"
# >> "DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD"
# >> "EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE"
# >> "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF"
# >> "GGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGG"
# >> "HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH"
# >> "IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII"
# >> "JJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJ"
