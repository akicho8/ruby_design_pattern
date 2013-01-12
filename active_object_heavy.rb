# -*- coding: utf-8 -*-
# Active Object - 非同期メッセージを受け取る、能動的なオブジェクト

require "thread"

# 「能動的なオブジェクト」を生成するクラス
class ActiveObjectFactory
  def self.create
    Proxy.new(Scheduler.new, Service.new)
  end
end

# メソッド呼び出し→オブジェクト生成に変換
class Proxy
  attr_accessor :scheduler, :service

  def initialize(scheduler, service)
    @scheduler = scheduler
    @service = service
  end

  # 担当クラスを起動だけしてスケジューリングする
  def disp(str)
    @scheduler.queue << DisplayCommand.new(@service, str) # 重要なのはここだけ
  end
end

# MethodRequestオブジェクトをexecするクラス
class Scheduler
  attr_accessor :queue

  def initialize
    @queue = Queue.new
    start
  end

  # 順番にスケジューリングされたのを実行していくスレッド
  def start
    Thread.new{loop{@queue.pop.exec}}
  end
end

# コマンドパターンになっている
class DisplayCommand
  def initialize(service, str)
    @service = service
    @str = str
  end
  def exec
    @service.disp(@str)
  end
end

# 実際の処理を行うクラス
class Service
  def disp(str)
    puts "disp: #{str}"
    sleep(0.01)
  end
end

obj = ActiveObjectFactory.create
Thread.start{
  # obj.disp を呼んでいる時点では裏で処理されていることはわからない
  3.times{|i|obj.disp(i)}
}.join

until obj.scheduler.queue.empty?; end

# >> disp: 0
# >> disp: 1
# >> disp: 2
