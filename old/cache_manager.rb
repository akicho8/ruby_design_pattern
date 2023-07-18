# http://www002.upp.so-net.ne.jp/ys_oota/mdp/Cache/index.htm

class Cache
  attr_accessor :max, :pool

  def initialize
    @max = 2
    @pool = []
  end

  def fetch(key)
    v = nil
    if index = @pool.find_index {|e|e[:key] == key}
      v = @pool.slice!(index)[:val]
    else
      v = yield
    end
    @pool = ([:key => key, :val => v] + @pool).take(@max)
    v
  end
end

cache = Cache.new
cache.fetch(:a){1}              # => 1
cache.pool                      # => [{:key=>:a, :val=>1}]
cache.fetch(:b){1}              # => 1
cache.pool                      # => [{:key=>:b, :val=>1}, {:key=>:a, :val=>1}]
cache.fetch(:a){2}              # => 1
cache.pool                      # => [{:key=>:a, :val=>1}, {:key=>:b, :val=>1}]
cache.fetch(:c){1}              # => 1
cache.pool                      # => [{:key=>:c, :val=>1}, {:key=>:a, :val=>1}]
