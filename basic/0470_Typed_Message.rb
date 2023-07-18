## Typed Message ##

#+BEGIN_SRC
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
#+END_SRC

# GUI アプリでイベントが起きるといろんなものが飛んできて美しくない switch 文ができてしまうあれのこと

