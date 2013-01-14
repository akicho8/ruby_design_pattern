# -*- coding: utf-8 -*-
# Future - 戻値必要

def request(x)
  Thread.start(x){|x|x}
end

t = []
t << request("A")
t << request("B")
t.collect(&:value) # => ["A", "B"]
