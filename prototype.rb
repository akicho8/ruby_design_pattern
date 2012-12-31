# -*- coding: utf-8 -*-

# クラスベース

class Cell; end                                # 細胞
class Plankton < Cell; end                     # プランクトン < 細胞
class Fish < Plankton; end                     # 魚 < プランクトン
class Monkey < Fish; def speek?; true end; end # 猿 < 魚
class Human < Monkey; end                      # 人間 < 猿

Human.new.speek?                # => true

# プロトタイプベース

cell = Object.new
plankton = cell.clone
fish = plankton.clone
monkey = fish.clone.tap{|o|def o.speek?; true end}
human = monkey.clone
human.speek?                    # => true

# その他の例

class Piece < Struct.new(:name)
end

class Box
  attr_accessor :showcase
  def initialize
    @showcase = {
      :rook => Piece.new("飛"),
    }
  end
  def create(name)
    @showcase[name].clone
  end
end

box = Box.new
box.create(:rook).name     # => "飛"
