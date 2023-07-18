## Before / After ##

# 基本形

#+BEGIN_SRC
begin
  # 前処理
ensure
  # 後処理
end

#+END_SRC

# RSpec 風

#+BEGIN_SRC
require "active_support/callbacks"

class C
  include ActiveSupport::Callbacks
  define_callbacks :before, :after

  class << self
    def before(...)
      set_callback(:before, ...)
    end

    def after(...)
      set_callback(:after, ...)
    end
  end

  def run
    run_callbacks :before
  ensure
    run_callbacks :after
  end

  before { p 1 }
  before { p 2 }
  after  { p 3 }
  after  { p 4 }
end

C.new.run
#+END_SRC

# ```:Output
# 1
# 2
# 3
# 4
# ```
# >> 1
# >> 2
# >> 3
# >> 4
