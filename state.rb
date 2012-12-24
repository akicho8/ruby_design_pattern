# -*- coding: utf-8 -*-

class OpenState
  def board
    "営業中"
  end
end

class CloseState
  def board
    "準備中"
  end
end

class Shop
  def change_state(hour)
    if (11..17).include?(hour)
      @state = OpenState.new
    else
      @state = CloseState.new
    end
  end
  def board
    @state.board
  end
end

shop = Shop.new
shop.change_state(10)
shop.board                      # => "準備中"
shop.change_state(11)
shop.board                      # => "営業中"
