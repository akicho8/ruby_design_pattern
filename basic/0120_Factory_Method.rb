## Factory Method ##

#+BEGIN_SRC
class Base
  def run
    object
  end
end

class App < Base
  def object
    String.new
  end
end

App.new.run
#+END_SRC

# * 人によって解釈というか使用目的がかなり異なる
#   * クラスの選択をサブクラスに押し付けるのが目的
#   * 単に複雑なインスタンス生成手順を別のクラスにまかせるのが目的
# * クラスの選択をサブクラスに押し付けるのが目的とした場合
#   * Template Method パターンでもある
#   * Java ではクラスの選択が難しいゆえに無駄に階層ができてしまう
#   * Ruby ならクラスをそのまま渡せばいい

