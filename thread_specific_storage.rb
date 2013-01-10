# -*- coding: utf-8 -*-
# Thread-Specific Storage - スレッド内グローバル変数

Thread.start{Thread.current["a"] = 1}.join
Thread.start{Thread.current["a"]}.value    # => nil

# 他の例

t = 1000.times.collect do
  Thread.start do
    100.times{|i|
      Thread.current["a"] ||= 0
      Thread.current["a"] += i
    }
  end
end
t.each(&:join).collect{|t|t["a"]}.uniq.size # => 1
