# http://www002.upp.so-net.ne.jp/ys_oota/mdp/TypedMessage/index.htm

class MouseMotion
end

class App
  def receive(e)
    case e
    when MouseMotion
    end
  end
end

app = App.new
app.receive(MouseMotion.new)
