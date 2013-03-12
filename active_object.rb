# -*- coding: utf-8 -*-
# Active Object - 非同期メッセージを受け取る、能動的なオブジェクト

require "thread"

class C
  def process # !> previous definition of process was here
    1 + 2
  end
end

obj = C.new
obj.process                        # => 3

# ↓

class C
  attr_accessor :queue

  def initialize
    @queue = Queue.new
    Thread.start do
      loop { @queue.pop.call }
    end
  end

  def process # !> method redefined; discarding old process
    @queue << proc{p 1 + 2}
  end
end

obj = C.new
obj.process
nil until obj.queue.empty?
# >> 3
