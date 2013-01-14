# -*- coding: utf-8 -*-
# Thread-Per-Message - 戻値不要

def request(x)
  Thread.start(x){|x|p x}
end

request("a")
request("b")

(Thread.list - [Thread.main]).each(&:join)
# >> "a"
# >> "b"
