# Single Threaded Execution - この橋を渡れるのはたった１人

require "thread"

# mutex がない場合

a = 0
b = 0
2.times.collect do
  Thread.start do
    2.times do
      a += 1
      Thread.pass
      b += 1
      p [a, b, (a == b)]
    end
  end
end.each(&:join)

# ある場合

mutex = Mutex.new
a = 0
b = 0
2.times.collect do
  Thread.start do
    2.times do
      mutex.synchronize do
        a += 1
        Thread.pass
        b += 1
        p [a, b, (a == b)]
      end
    end
  end
end.each(&:join)
# >> [2, 1, false]
# >> [2, 2, true]
# >> [4, 3, false]
# >> [4, 4, true]
# >> [1, 1, true]
# >> [2, 2, true]
# >> [3, 3, true]
# >> [4, 4, true]
