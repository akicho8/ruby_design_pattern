# -*- coding: utf-8 -*-
# Balking - 不要であればすぐにリターンする

require "mutex_m"

class C
  include Mutex_m
  def initialize
    super
    @change = false
  end

  def execute(str, t)
    synchronize do
      if @change
        p "処理中のため#{str}はスキップ"
        return
      end
      @change = true

      p str
      sleep(t) # sleepはsynchronizeの中で行わないとエラーになる

      @change = false
    end
  end
end

x = C.new
threads = []
threads << Thread.start{x.execute("a", 0.1)}
threads << Thread.start{x.execute("b", 0)}
sleep(0.1)
threads << Thread.start{x.execute("c", 0)}
threads.collect(&:join)
# >> "a"
# >> "処理中のためbはスキップ"
# >> "c"
