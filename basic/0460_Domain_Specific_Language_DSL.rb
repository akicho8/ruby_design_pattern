## Domain Specific Language (DSL) ##

#+BEGIN_SRC
class Environment
  def ax
    :AX
  end

  def bx
    :BX
  end

  def mov(left, right)
    puts "#{right} --> #{left}"
  end
end

Environment.new.instance_eval(<<~EOT)
mov ax, 0b1111
mov bx, ax
EOT
#+END_SRC

# ```:Output
# 15 --> AX
# AX --> BX
# ```

# * rake や capistrano が有名
# * 一般的には `eval(File.read(xxx))` の形で実行する
# * でも ActiveRecord の belongs_to, has_many なども DSL の一種
# * 括弧を使わなくなったら DSL みたいなもの
