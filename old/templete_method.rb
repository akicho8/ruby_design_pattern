class Base
  def build
    "(#{body})"
  end
end

class App < Base
  def body
    "ok"
  end
end

App.new.build                   # => "(ok)"
