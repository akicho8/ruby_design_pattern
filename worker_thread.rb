# -*- coding: utf-8 -*-
# 8. Worker Thread - 仕事がくるまで待ち仕事がきたら働く

require "thread"

# 仕事
class Request
  attr_reader :number

  def initialize(name, number)
    @name = name
    @number = number
  end

  def execute
    sleep(1.0 / rand(100))
    to_s
  end

  def to_s
    "[Request from #{@name} No.#{@number}]"
  end
end

# 仕事の依頼をする人
def client_thread(*arg)
  Thread.new(*arg) do |name, channel, num|
    num.times do |i|
      channel << Request.new(name, i)
      sleep(1.0 / rand(1000))
    end
  end
end

# 仲介役だけどサイズ分だけ処理するスレッドを生成する
class Channel < SizedQueue
  def initialize(size, check)
    super(size)
    @t = []
    size.times do |i|
      @t << Thread.new do
        loop do
          request = pop
          check << request.number
          # p ["Worker-#{i}", request.execute]
        end
      end
    end
  end
  def kill
    @t.each(&:kill)
  end
end

check = []
channel = Channel.new(2, check)
ct = []
ct << client_thread("Alice", channel, 5)
ct << client_thread("Bobby", channel, 5)
ct.each{|e|e.join}
while check.size < 10; end      # これを入れて処理スレッドと同期を取る
channel.kill
p check.sort
p ((0...5).to_a * 2).sort
# >> [0, 0, 1, 1, 2, 2, 3, 3, 4, 4]
# >> [0, 0, 1, 1, 2, 2, 3, 3, 4, 4]
