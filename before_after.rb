# -*- coding: utf-8 -*-
# before/after
begin
  p "before"
  1 / 0
rescue => error
  p error
ensure
  p "after"
end
# >> "before"
# >> #<ZeroDivisionError: divided by 0>
# >> "after"
