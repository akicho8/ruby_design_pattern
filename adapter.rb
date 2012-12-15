# -*- coding: utf-8 -*-

# ダメなクラスを
class Color
  def red
    "#00f"
  end
end

# ラップして再利用
class Palette < Color
  alias blue red
end
Palette.new.blue # => "#00f"
