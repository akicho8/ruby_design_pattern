class Iterator
  def initialize(object)
    @object = object
    @index = 0
  end
  def has_next?
    @index < @object.size
  end
  def next
    @object[@index].tap {@index += 1}
  end
end

class Array
  def iterator
    Iterator.new(self)
  end
end

ary = ["a", "b", "c"]
i = 0
while i < ary.size
  p ary[i]
  i += 1
end

ary = ["a", "b", "c"]
it = ary.iterator
while it.has_next?
  p it.next
end

class Array
  def iterator
    it = Iterator.new(self)
    while it.has_next?
      yield it.next
    end
  end
end

ary = ["a", "b", "c"]
ary.iterator {|v|p v}

["a", "b", "c"].each do |v|
  p v
end
