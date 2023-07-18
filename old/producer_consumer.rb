# Producer Consumer

require "thread"

queue = SizedQueue.new(1)
producer = Thread.start {
  4.times {|i|
    p ["作成", i]
    queue.push(i)
  }
  p "作成側は先に終了"
}
consumer = Thread.start {
  4.times {
    p ["使用", queue.pop]
    sleep(0.01)
  }
}
producer.join
consumer.join
# >> ["作成", 0]
# >> ["作成", 1]
# >> ["使用", 0]
# >> ["作成", 2]
# >> ["使用", 1]
# >> ["作成", 3]
# >> ["使用", 2]
# >> "作成側は先に終了"
# >> ["使用", 3]
