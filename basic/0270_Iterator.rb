## Iterator ##

#+BEGIN_SRC
class Iterator
  def initialize(object)
    @object = object
    @index = 0
  end

  def next?
    @index < @object.size
  end

  def next
    @object[@index].tap { @index += 1 }
  end
end

class Array
  def xxx
    it = Iterator.new(self)
    while it.next?
      yield it.next
    end
  end
end

%w(a b c).xxx { |e| e }
#+END_SRC

# * each みたいなやつのこと
# * 自力で書く機会は少ないけど構造は知っときたい

