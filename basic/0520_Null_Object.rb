## Null Object ##

#+BEGIN_SRC
class NullLogger
  def debug(...)
  end
end

logger = NullLogger.new
logger.debug("x")                # => nil
#+END_SRC

# * インターフェイスが同じ「何もしない」オブジェクト
#   * `/dev/null` にリダイレクトするのに似ている
# * 「無」を上手に表すとnull安全にできる
#   * 例えば計算するとき「無し」を 0 と表現する
#     * こうすることで0除算になったりと余計面倒になる場合もある
# * あちこちで if を書き散らして除外している場合に置き換えると綺麗になる
# * 「Nullなんとか」な命名は技術駆動命名なので Null より Empty の方がいいかもしれない

