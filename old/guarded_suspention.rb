# Guarded Suspention - 用意が出来るまで待つ

require "thread"

queue = Queue.new # スレッド間の送受信用

send_num = 10

# 送信側
sender = Thread.start do
  Thread.current[:data] = []
  send_num.times do |i|
    sleep(rand(0..0.01))
    queue << i
    Thread.current[:data] << i
  end
end

# 受信側
receiver = Thread.start do
  Thread.current[:data] = []
  send_num.times do
    sleep(rand(0..0.001))
    # pop出来ないとスレッドが自動停止してくれる。popだけどFIFO。間違いそう。
    Thread.current[:data] << queue.pop
  end
end

sender.join
receiver.join

# 正常にデータが受け取れているか確認
sender[:data]   # => [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
receiver[:data] # => [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
