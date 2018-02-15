# 【L】Liskov Substitution Principle - リスコフの置換原則
# 派生型はその基本型と置換可能でなければならない。

class B
  def list
    [0, 1, 2, 3]
  end
end

class C < B
  def list
    super.find_all(&:even?).join("-")
  end
end

C.new.list                      # => "0-2"

# B#list では数字の配列を返すというお約束になっているのに C#list は文字列にまで変換しているのがだめ。

class C2 < B
  def list
    super.find_all(&:even?)
  end

  def a
    list.join("-")
  end
end

C2.new.a                        # => "0-2"
