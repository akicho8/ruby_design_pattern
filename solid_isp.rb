# インタフェース分離の原則 (ISP: Interface Segregation Principle)

# I クラスの a と b に繋りはないので I クラスを分けましょうという話

class I
  def a
  end

  def b
  end
end

class C1
  def initialize
    @i = I.new
  end

  def run
    @i.a
  end
end

class C2
  def initialize
    @i = I.new
  end

  def run
    @i.b
  end
end

C1.new.run
C2.new.run

# ↓

class I1
  def a
  end
end

class I2
  def b
  end
end

class C1
  def initialize
    @i = I1.new
  end

  def run
    @i.a
  end
end

class C2
  def initialize
    @i = I2.new
  end

  def run
    @i.b
  end
end

C1.new.run
C2.new.run
