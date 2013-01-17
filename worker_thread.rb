# -*- coding: utf-8 -*-
# 8. Worker Thread - 仕事がくるまで待ち仕事がきたら働く

require "thread"

class Channel < SizedQueue
  attr_reader :threads

  def initialize(size)
    super(size)
    @threads = size.times.collect do |i|
      Thread.start(i) do |i|
        loop do
          request = pop
          p "スレッド#{i}が#{request}を担当"
          sleep(1)
        end
      end
    end
  end
end

channel = Channel.new(1)
t = Time.now
4.times{|i|channel << i}
nil until channel.size.zero? && channel.threads.all?{|t|t.status == "sleep"}
puts "%.1f s" % (Time.now - t)

channel = Channel.new(4)
t = Time.now
4.times{|i|channel << i}
nil until channel.size.zero? && channel.threads.all?{|t|t.status == "sleep"}
puts "%.1f s" % (Time.now - t)
# >> "スレッド0が0を担当"
# >> "スレッド0が1を担当"
# >> "スレッド0が2を担当"
# >> "スレッド0が3を担当"
# >> 3.3 s
# >> "スレッド1が0を担当"
# >> "スレッド0が1を担当"
# >> "スレッド3が2を担当"
# >> "スレッド2が3を担当"
# >> 0.8 s
