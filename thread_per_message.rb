# -*- coding: utf-8 -*-
# Thread-Per-Message - この仕事、やっといて

class User
  def request(*args)
    Thread.start(*args){|x, t|sleep(t);p x}
  end
end

host = User.new
host.request("a", 0.2)
host.request("b", 0.1)
(Thread.list - [Thread.main]).each(&:join)
# >> "b"
# >> "a"
