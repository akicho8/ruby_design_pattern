## Cache Manager ##

#+BEGIN_SRC
class Cache
  attr_accessor :max, :pool

  def initialize
    @max = 2
    @pool = []
  end

  def fetch(key)
    v = nil
    if index = @pool.find_index { |e| e[:key] == key }
      v = @pool.slice!(index)[:val]
    else
      v = yield
    end
    @pool = ([key: key, val: v] + @pool).take(@max)
    v
  end
end

cache = Cache.new
cache.fetch(:a) { 1 }           # => 1
cache.pool                      # => [{:key=>:a, :val=>1}]
cache.fetch(:b) { 1 }           # => 1
cache.pool                      # => [{:key=>:b, :val=>1}, {:key=>:a, :val=>1}]
cache.fetch(:a) { 2 }           # => 1
cache.pool                      # => [{:key=>:a, :val=>1}, {:key=>:b, :val=>1}]
cache.fetch(:c) { 1 }           # => 1
cache.pool                      # => [{:key=>:c, :val=>1}, {:key=>:a, :val=>1}]
#+END_SRC

# * 最後に使ったキャッシュほど上に来る
# * a b で pool は b a の順になり、次の a で a b になり、次の c で c a b になる
# * しかしキャッシュサイズは 2 なので b が死んで c a

