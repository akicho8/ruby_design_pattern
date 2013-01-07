# -*- coding: utf-8 -*-
# 9. Future - 引き換え券を、お先にどうぞ

def request(count, c)
  Thread.start do
    cake = ""
    count.times{Thread.pass; cake << c}
    cake
  end
end

t = []
t << request(2, "A")
t << request(3, "B")
t << request(4, "C")
t.each{|e|e.join}
t.collect(&:value)              # => ["AA", "BBB", "CCCC"]
