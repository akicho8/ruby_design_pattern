* デザインパターン覚え書き
** 一般 (GOF)

| 名前                    | 概要                                                      |
|-------------------------|-----------------------------------------------------------|
| Adapter                 | メソッドが足りなくて階層的に増やすときに使う(重要)        |
| Observer                | 通知元は通知先のことを知らないでよいことが前提            |
| Iterator                | each のこと                                               |
| Template Method         | new すると initialize                                     |
| Singleton               | インスタンスをグローバル変数にしたいとき用                |
| Prototype               | new ではなく clone で                                     |
| Builder                 | xml.body {xml.p("x")}                                     |
| Abstract Factory        | クラスをハードコーディングしない                          |
| Strategy                | テトリミノのツモ                                          |
| Composite               | def x; @commands.collect(&:x); end                        |
| Decorator               | to_html をつけたいけど元のクラスは汚したくないとき用      |
| Visitor                 | Pathname.glob("*.rb") {...}                               |
| Chain of Responsibility | resolve? なら受ける。(順にリンクしてないといけないか疑問) |
| Facade                  | 単にメソッド化？                                          |
| Mediator                | A と B で困ったら Mediator クラスが必要                   |
| Memento                 | 前の状態に戻りたいとき用                                  |
| State                   | 一段階層を深くしてフラットにインスタンスを切り替える      |
| Flyweight               | メモ化のこと                                              |
| Proxy                   | 必要になってから作る                                      |
| Command                 | 命令をクラスにする                                        |
| Interpreter             | 文法規則をクラスで表現                                    |

** スレッド用

| 名前                      | 備考                                  |
|---------------------------|---------------------------------------|
| Single Threaded Execution | 排他制御 → する                      |
| Immutable                 | 排他制御 → しないでいい              |
| Guarded Suspension        | 処理できるまで → 待つ (別に増えない) |
| Worker Thread             | 処理できるまで → 待つ (増えると速い) |
| Balking                   | 処理できるまで → 待たない            |
| Thread Per Message        | 処理を投げる → 戻値いらん            |
| Future                    | 処理を投げる → 戻値いる              |
| Producer-Consumer         | 作る → キュー → 使う                |
| Read-Write Lock           | 読み込み中は書き込まない              |
| Two-Phase Termination     | 外から殺さない                        |
| Thread Specific Storage   | スレッド個別のグローバル変数          |

** その他

| 名前               | 概要                                         |
|--------------------|----------------------------------------------|
| Active Object      | 非同期メッセージを受け取る                   |
| Null Object        | なにもしないオブジェクトにしてかわす         |
| Object Pool        | 生成に時間がかかるものを使い回す             |
| Pluggable Selector | 横着ポルモルフィック(？)                     |
| Before / After     | 後処理を必ず実行                             |
| Factory Method     | new を別オブジェクトが行うだけ(？)           |
| Bridge             | 要はDRYにしとけば拡張が楽ちんってことっぽい  |
| Typed Message      | GUIでよくある SDL::Event::Quit みたいなアレ  |
| Cache Manager      | 使ったキャッシュは先頭に移動                 |
| Component Bus      | Observer が Subject を握っている             |
| Composed Method    | メソッド化してなんなら再利用できるようにする |

** SOLID

| 略  | 名前                            | 日本語             | ダメ                                       | 改善方法                   | 備考               |
|-----|---------------------------------|--------------------|--------------------------------------------|----------------------------|--------------------|
| SRP | Single Responsibility Principle | 単一責任           | 1つのクラスに複数の機能                    | クラス分割                 |                    |
| OCP | Open-Closed Principle           | オープンクローズド | 拡張しずらく、拡張するとクラスの変更が必要 | 処理するインスタンスを渡す | ストラテジーのこと |
| LSP | Liskov Substitution Principle   | リスコフの置換     | 継承したメソッドをまったく違うものにした   | 親クラスの方針を察する     |                    |
| ISP | Interface Segregation Principle | インタフェース分離 | 抽象クラスが複雑                           | 抽象クラスを分割           |                    |
| DIP | Dependency Inversion Principle  | 依存関係逆転       | ストラテジー用のオブジェクトに依存         | 依存してはいけない         |                    |

* コード
** 一般 (GOF)

*** Mediator

```ruby
class A
  attr_accessor :state
  def initialize(b)
    @b = b
    @state = true
  end

  def changed
    @b.visible = @state
  end
end

class B
  attr_accessor :visible
end
```

    改善。A と B に Mediator のインスタンスを持たせて changed は Mediator のインスタンスに投げる。

```ruby
class Mediator
  attr_reader :a, :b
  def initialize
    @a = A.new(self)
    @b = B.new(self)
  end

  def changed
    @b.visible = @a.state
  end
end

class A
  attr_accessor :state
  def initialize(mediator)
    @mediator = mediator
    @state = true  end

  def  changed
    @mediator.changed
  end
end

class B
  attr_accessor :visible
  def initialize(mediator)
    @mediator = mediator
  end
end
```

```ruby
m = Mediator.new
m.a.state = true
m.a.changed
m.b.visible # => true
```

*** Abstract Factory

    都合が悪くなってきたから A と B をハードコーディングしているのをやめようってこと

```ruby
class C
  def run
    A.new + B.new
  end
end
```

    ↓

```ruby
class C
  def run
    @factory.new_x + @factory.new_y
  end
end
```

    将棋のDSLのところから抜粋した例

    Builder#build では10個ぐらいのクラスを使ってあれこれする。
    最初は A.new("x") と書けばいいけど、別の挙動になって欲しいときは、
    「Aクラス」と、ハードコーディングされていることが問題になってくる。
    そこで FactorySet1 などで「Aクラスの」部分を動的にする。
    動的にするのが目的なので方法はなんでもいいはず。
    ruby なら A 自体を引数で渡せばいいし。
    Java だとそういうことはできないから new_a のなかで A.new を呼ぶことになってるはず。

```ruby
class Builder
  def initialize(factory)
    @factory = factory
  end

  def build
    @factory.new_a("x").build
  end
end

class A
  def initialize(value)
    @value = value
  end

  deff build
    "(#{@value})"
  end
end

class FactorySet1
  def new_a(*args)
    A.new(*args)
  end
end

class B
  def initialize(value)
    @value = value
  end

  deff build
    "<#{@value}>"
  end
end

class FactorySet2
  def new_a(*args)
    B.new(*args)
  end
end

Builder.new(FactorySet1.new).build # => "(x)"
Builder.new(FactorySet2.new).build # => "<x>"
```

*** Factory Method

```ruby
class X
end

class F
  def create
    X.new
  end
end

class C
  attr_accessor :v
  def initialize(f)
    @v = f.create
  end
end

C.new(F.new).v                  # => #<X:0x007fb213905a98>
```

*** Chain of Responsibility

```ruby
class Chainable
  def initialize(_next = nil)
    @_next = _next
  end

  deff support(q)
    if resolve?(q)
      answer(q)
    elsif @_next
      @_next.support(q)
    else
      "知らん"
    end
  end
end

class Alice < Chainable
  def resolve?(q)
    q == "1+2は？"
  end

  def answer(q)
    "3"
  end
end

class Bob < Chainable
  def resolve?(q)
    q == "2*3は？"
  end

  defef answer(q)
    "6"
  end
end

alice = Alice.new(Bob.new)
alice.support("1+2は？") # => "3"
alice.support("2*3は？") # => "6"
alice.support("2/1は？") # => "知らん"
```

*** Proxy

    decoratorに似ているけど decoratorほどデコレートしないし便利メソッドを追加しない。
    元のインスタンスを *呼ぶ* or *呼ばない* or *まねる* or *あとで呼ぶ* ぐらいしかない。

```ruby
class User
  attr_accessor :name, :point
  def initialize(name)
    @name = name
    @point = 0
  end

  def deposit(amount)
    @point += amount
  end
end
```

    ガードプロキシ(呼んだり、呼ばなかったり)

```ruby
class UserProxy
  BlackList = ["alice"]

  def initialize(user)
    @user = user
  end

  def point
    @user.point
  end

  def method_missing(*args)
    if BlackList.include?(@user.name)
      return
    end
    @user.send(*args)
  end
end

user = User.new("alice")
user.deposit(1)
user.point                      # => 1

user = UserProxy.new(User.new("alice"))
user.deposit(1)
user.point                      # => 0
```

    仮想プロキシ(まねる)

```ruby
class VirtualPrinter
  def name
    "BJ10V"
  end

  def print(str)
  end
end
```

    遅延実行(あとで呼ぶ)

```ruby
class VirtualPrinter
  def name
    "BJ10V"
  end

  def print(str)
    @printer ||= RealPrinter.new
    @printer.print(str)
  end
end

class RealPrinter
  def initialize
    puts "とてつもなく時間がかかる初期化処理..."
  end

  def name
    "BJ10V"
  end

  def print(str)
    str
  end
end

printer = VirtualPrinter.new
printer.name        # => "BJ10V"
printer.print("ok") # => "ok"
# >> とてつもなく時間がかかる初期化処理...
```

*** Command + Composite

```ruby
class Command
end

class FooCommand < Command
  def execute
    "a"
  end
end

class BarCommand < Command
  def execute
    "b"
  end
end

class CompositeCommand < Command
  def initialize
    @commands = []
  end

  def <<(command)
    @commands << command
  end

  def execute
    @commands.collect(&:execute)
  end
end

command = CompositeCommand.new
command << FooCommand.new
command << BarCommand.new

command.execute                 # => ["a", "b"]
```

    コードブロックを使ってクラス爆発を防ぐ

```ruby
class BazCommand < Command
  def initialize(&block)
    @command = block
  end

  def execute
    @command.call
  end
end

command << BazCommand.new {"c"}
command << BazCommand.new {"d"}

command.execute                 # => ["a", "b", "c", "d"]
```

*** Prototype

    クラスベース

```ruby
class Cell; end                                # 細胞
class Plankton < Cell; end                     # プランクトン < 細胞
class Fish < Plankton; end                     # 魚 < プランクトン
class Monkey < Fish; def speek?; true end; end # 猿 < 魚
class Human < Monkey; end                      # 人間 < 猿

Human.new.speek?                # => true
```

    プロトタイプベース。JavaScript はこのタイプ。

```ruby
cell = Object.new
plankton = cell.clone
fish = plankton.clone
monkey = fish.clone.tap {|o|def o.speek?; true end}
human = monkey.clone
human.speek?                    # => true
```

    その他の例

```ruby
class Piece < Struct.new(:name)
end

class Box
  attr_accessor :showcase
  def initialize
    @showcase = {
      :rook => Piece.new("飛"),
    }
  end

  def create(name)
    @showcase[name].clone
  end
end

box = Box.new
box.create(:rook).name     # => "飛"
```

*** Template Method

```ruby
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
```

*** Iterator

    i が邪魔

```ruby
ary = ["a", "b", "c"]
i = 0
while i < ary.size
  p ary[i]
  i += 1
end
```

    ここで Iterator

```ruby
class Iterator
  def initialize(object)
    @object = object
    @index = 0
  end

  def has_next?
    @index < @object.size
  end

  def next
    @object[@index].tap {@index += 1}
  end
end

class Array
  def iterator
    Iterator.new(self)
  end
end
```

    i が消えた

```ruby
it = ary.iterator
while it.has_next?
  p it.next
end
```

    it も消す

```ruby
class Array
  def iterator
    it = Iterator.new(self)
    while it.has_next?
      yield it.next
    end
  end
end

ary.iterator {|v|p v}
```

    each とほぼ同じになった

*** Memento

    簡易ブラックジャックを行うプレイヤー

```ruby
class Player
  attr_accessor :cards

  def initialize
    @cards = []
  end

  def take
    @cards << rand(1..13)
  end

  def score
    @cards.reduce(&:+)
  end
end
```

    5回カードを引くゲームを3回行うと全部21を越えてしまった

```ruby
3.times do
  player = Player.new
  5.times do
    player.take
  end
  player.score                  # => 33, 37, 52
end
```

    そこでMementoパターン

```ruby
class Player
  def create_memento
    @cards.clone
  end

  def restore_memento(object)
    @cards = object.clone
  end
end
```

    21点未満の状態を保持しておき21を越えたら元に戻す

```ruby
3.times do
  player = Player.new
  memento = nil
  5.times do
    player.take
    if player.score < 21
      memento = player.create_memento
    elsif player.score > 21
      player.restore_memento(memento)
    end
  end
  player.score                  # => 18, 19, 15
end
```

    この例の場合なら単純に clone してそれを戻してもいい。
    少し用途が違うような気もするけど Marshal.load(Marshal.dump(player)) や marshal_dump marshal_load も考えとく。

*** Visitor

```ruby
Pathname.glob("**/*.rb") {|f| }

Niconico.crawler do |video|
  if video.mylist >= 10000
    video.download
  end
end
```

*** Flyweight

    メモ化すること。インスタンスプールとも言う。

```ruby
module Wave
  def self.load(file)
    p "load #{file}"
    file
  end
end

class Sound
  def self.get(name)
    @cache ||= {}
    @cache[name] ||= Wave.load("#{name}.wav")
  end
end

Sound.get("blue")               # => "blue.wav"
Sound.get("cyan")               # => "cyan.wav"
Sound.get("blue")               # => "blue.wav"
# >> "load blue.wav"
# >> "load cyan.wav"
```

*** Builder

```ruby
class Node
  attr_reader :name, :nodes

  def initialize(name)
    @name = name
    @nodes = []
  end
end
```

    見た目が汚い

```ruby
root = Node.new("root")
root.nodes << Node.new("a")
root.nodes << Node.new("b")
root.nodes << (c = Node.new("c"))
c.nodes << Node.new("d")
c.nodes << Node.new("e")
c.nodes << (f = Node.new("f"))
f.nodes << Node.new("g")
f.nodes << Node.new("h")

root.nodes.collect {|e|e.name}                       # => ["a", "b", "c"]
root.nodes.last.nodes.collect {|e|e.name}            # => ["d", "e", "f"]
root.nodes.last.nodes.last.nodes.collect {|e|e.name} # => ["g", "h"]
```

    ↓改善

```ruby
class Node
  def add(name, &block)
    tap do
      node = self.class.new(name)
      @nodes << node
      if block_given?
        node.instance_eval(&block)
      end
    end
  end
end
```

    簡潔になった

```ruby
root = Node.new("root")
root.instance_eval do
  add "a"
  add "b"
  add "c" do
    add "d"
    add "e"
    add "f" do
      add "g"
      add "h"
    end
  end
end
```

    結果も同じ

```ruby
root.nodes.collect {|e|e.name}                       # => ["a", "b", "c"]
root.nodes.last.nodes.collect {|e|e.name}            # => ["d", "e", "f"]
root.nodes.last.nodes.last.nodes.collect {|e|e.name} # => ["g", "h"]
```

**** mail gem の例

     これだと面倒なので

```ruby
mail = Mail.new
mail.to = Mail::AddressContainer.new("alice <alice@example.net>")
```

     改善

```ruby
mail = Mail.new
mail.to = "alice <alice@example.net>"
```

     内部でこっそりインスタンスを生成している

```ruby
mail.to.class      # => Mail::AddressContainer
```

*** State

```ruby
class OpenState
  def board
    "営業中"
  end
end

class CloseState
  def board
    "準備中"
  end
end

class Shop
  def change_state(hour)
    if (11..17).include?(hour)
      @state = OpenState.new
    else
      @state = CloseState.new
    end
  end

  def board
    @state.board
  end
end

shop = Shop.new
shop.change_state(10)
shop.board                      # => "準備中"
shop.change_state(11)
shop.board                      # => "営業中"
```

*** Facade

    例えばこんなのは

```ruby
message = Message.new(:date => Time.now)
message.from = User.find_by_name("alice")
message.to   = User.find_by_name("bob")
message.body = "..."
if message.valid?
  message.save!
end
```

    以下のように書きやすくまとめるというだけ？

```ruby
Message.deliver(:from => "alice", :to => "bob", :body => "...")
```

*** Bridge

    機能の階層と実装の階層を分けるって言っても Strategy と何が違うのかよくわからない。
    要は DRY にしとけば拡張が楽ちんということらしい。
    以下のコードは x y の実装2つと、囲まない囲むの2つの機能を組み合わせると2x2で4つのクラスが必要になる。
    このまま拡張していって実装と機能がそれぞれ10個あると100個のクラスを作らないといけなくなる。

```ruby
class A
  def run
    "x"
  end
end

class B
  def run
    "y"
  end
end

class AA < A
  def run
    "(x)"
  end
end

class BB < B
  def run
    "(y)"
  end
end
```

    改善

```ruby
class A
  def initialize(obj)
    @obj = obj
  end

  def run
    @obj
  end
end

class AA < A
  def run
    "(#{@obj})"
  end
end
```

*** Decorator

    proxyにそっくりだけど遅延実行や実行条件には関心がない。

    このクラスの

```ruby
class User
  def name
    "alice"
  end
end
```

    インスタンスを渡してラップするのが普通

```ruby
class UserDecorator
  def initialize(object)
    @object = object
  end

  def to_xxx
    "(#{@object.name})"
  end
end

UserDecorator.new(User.new).to_xxx # => "(alice)"
```

    もっとシンプルにするなら

```ruby
require "delegate"

class UserDecorator < SimpleDelegator
  def to_xxx
    "(#{name})"
  end
end

UserDecorator.new(User.new).to_xxx # => "(alice)"
```

    というか最初から以下の継承すればいいような気がするけどこれだと既存のインスタンスをラップすることができない。

```ruby
class UserDecorator < User
  def to_xxx
    "(#{name})"
  end
end

UserDecorator.new.to_xxx # => "(alice)"
```

    継承なら DelegateClass でもできるようだけど利点がわからない。Userが重複していて気持ち悪いのがやや気になる。

```ruby
require "delegate"

class UserDecorator < DelegateClass(User)
  def initialize
    super(User.new)
  end

  def to_xxx
    "(#{name})"
  end
end

UserDecorator.new.to_xxx # => "(alice)"
```

*** Observer

    実行結果が不要なときに使う。
    結果が必要なら Strategy へ。
    Observer 側に player (Subject) を渡して player.add_observer(self) は、まわりくどいので自分はやらない。
    Observer に player を握らせたら Component Bus パターンになるっぽい。

    密結合状態を

```ruby
class Player
  def initialize
    @paint = Paint.new
    @network = Network.new
  end

  def notify
    if @paint
      @paint.font(0, 0, status)
    end
    if @network
      @network.post(status)
    end
  end
end
```

    解消

```ruby
class Player
  attr_accessor :observers
  def initialize
    @observers = []
  end

  def notify
    @observers.each do |observer|
      observer.update(self)
    end
  end
end

player = Player.new
player.observers << Paint.new
player.observers << Network.new
```

**** 標準ライブラリ

```ruby
require "observer"

class Player
  include Observable

  def notify
    changed
    notify_observers(self)
  end
end

player = Player.new
player.add_observer(Paint.new)
player.add_observer(Network.new)
player.notify
```

    なんなら自分をオブザーバーにしてもいい

```ruby
require "observer"
class Player
  include Observable

  def initialize
    add_observer(self) # add_observer(self, :draw) のように通知メソッド変更可
  end

  def notify
    changed
    notify_observers(self)
  end

  def update(player)
    player                      # => #<Player:0x007ff9098472e0 ...>
  end
end

player = Player.new
player.notify
```

*** Component Bus

    Observer たちがデータ共有したいので、Subject を共有することにしたパターンらしい。
    http://www002.upp.so-net.ne.jp/ys_oota/mdp/ComponentBus/ 参照。

```ruby
class Player
  include Observable

  attr_accessor :data

  def notify
    changed
    notify_observers
  end
end

class Display
  def initialize(player)
    player.add_observer(self)
    @player = player    # Subjectを握っている
  end

  def update
  end

  def data
    @player.data
  end
end
```

    汎用性のあった Observer が Subject 依存になるデメリットも考慮すること。

*** Singleton

    グローバル変数を使うぐらいなら

```ruby
class C
  private_class_method :new
  def self.instance
    @instance ||= new
  end
end

C.instance # => #<C:0x007f98e404a518>
C.instance # => #<C:0x007f98e404a518>
```

    標準ライブラリを使った場合

```ruby
require "singleton"

class C
  include Singleton
end

C.instance # => #<C:0x007f98e509f558>
C.instance # => #<C:0x007f98e509f558>
```

    そこまできばらなくても次のようなコードで充分なことも多い

```ruby
module M
  extend self

  def func
  end
end
```

*** Strategy

    基本形

```ruby
class Random
  def next
    rand(7)
  end
end

class RedOnly
  def next
    6
  end
end

# テトリミノのツモはダイス次第
class Player
  def initialize(dice)
    @dice = dice
  end

  def run
    7.times.collect { @dice.next }
  end
end

Player.new(Random.new).run  # => [1, 5, 4, 1, 0, 0, 6]
Player.new(RedOnly.new).run # => [6, 6, 6, 6, 6, 6, 6]
```

    Rubyなら

```ruby
class Player
  def initialize(&dice)
    @dice = dice
  end

  def run
    7.times.collect { @dice.call }
  end
end

Player.new { rand(7) }.run  # => [2, 5, 5, 6, 6, 2, 0]
Player.new { 6 }.run        # => [6, 6, 6, 6, 6, 6, 6]
```

    これでクラスが爆発しなくなる

*** Adapter

```ruby
class C
  def f1
    "x"
  end
end
```

    継承版

```ruby
class C2 < C
  def f2
    f1 * 2
  end
end
```

    委譲版

```ruby
class C3
  def initialize
    @c = C.new
  end

  def f1
    @c.f1
  end

  def f2
    f1 * 2
  end
end
```

    f1 メソッドを書くのが面倒なとき

```ruby
require "delegate"

class C4 < SimpleDelegator
  def initialize
    super(C.new)
  end

  def f2
    f1 * 2
  end
end
```

```ruby
[C2.new.f1, C2.new.f2]      # => ["x", "xx"]
[C3.new.f1, C3.new.f2]      # => ["x", "xx"]
[C4.new.f1, C4.new.f2]      # => ["x", "xx"]
```

**** Factory Method だと思っていたら Adapter だったもの

     こういうのはあっとゆうまに search メソッドが肥大化する。
     で、Userのクラスメソッドとしてメソッドを分離するという *間違ったリファクタリング* を行ってしまいがち。

```ruby
class User
  def self.search(query)
    ["name like ?", "%#{query}%"]
  end
end

User.search("alice")                     # => ["name like ?", "%alice%"]
```

    そうなりそうなら次のように改善

```ruby
class User
  def self.search(*args)
    UserSearch.new(self, *args).run
  end
end

class UserSearch
  def initialize(model, query)
    @model = model
    @query = query
  end

  def run
    ["name like ?", "%#{@query}%"]
  end
end

User.search("alice")   # => ["name like ?", "%alice%"]
```

    UserSearch の中でいくらメソッドを増やしても元のUserには影響がない。

    次は例が悪いけど @color から変換するメソッドを Player 自体に入れてしまって Player クラスがカオスになってしまうケース。

```ruby
class Player
  attr_accessor :color
  def initialize
    @color = :blue
  end
end
```

    ここでプレイヤーの色を #00F で返したかったので rgb メソッド定義した。これがダメ。

```ruby
class Player
  def rgb
    if @color == :blue
      "#00F"
    end
  end
end
```

    改善

```ruby
class ColorInfo
  attr_accessor :color

  def initialize(color)
    @color = color
  end

  def rgb
    "#00F"
  end
end

class Player
  def color_info
    ColorInfo.new(@color)
  end
end

Player.new.color_info.rgb            # => "#00F"
```

    こうすればいくらでも窮屈な状態から脱出できる。
    もし、青が欲しければ ColorInfo に足せばいい。

```ruby
class ColorInfo
  def human_name
    "青"
  end
end

Player.new.color_info.human_name     # => "青"
```

    もっと言うなら最初から @color は ColorInfo のインスタンスにしときゃいい。

*** Interpreter

    シンプルなDSL

```ruby
class Expression
end

class Value < Expression
  def initialize(value)
    @value = value
  end

  def evaluate
    @value
  end
end

class Add < Expression
  def initialize(left, right)
    @left, @right = left, right
  end

  def evaluate
    @left.evaluate + @right.evaluate
  end
end

def A(l, r)
  Add.new(Value.new(l), Value.new(r))
end

expr = A 1, 2
expr.evaluate # => 3
```

    他のコードに変換

```ruby
class Expression
end

class Value < Expression
  attr_accessor :value
  def initialize(value)
    @value = value
  end

  def evaluate
    ["mov  ax, #{@value}"]
  end
end

class Add < Expression
  def initialize(left, right)
    @left, @right = left, right
  end

  def evaluate
    code = []
    code << @left.evaluate
    code << "mov  dx, ax"
    code << @right.evaluate
    code << "add  ax, dx"
  end
end

def A(l, r)
  Add.new(Value.new(l), Value.new(r))
end

expr = A 1, 2
puts expr.evaluate
# >> mov  ax, 1
# >> mov  dx, ax
# >> mov  ax, 2
# >> add  ax, dx
```

*** Typed Message

    GUIアプリでイベント起きるといろんなものが飛んできて美しくないswitch文ができてしまうアレのこと

    http://www002.upp.so-net.ne.jp/ys_oota/mdp/TypedMessage/index.htm 参照

```ruby
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
```

*** Cache Manager

    http://www002.upp.so-net.ne.jp/ys_oota/mdp/CacheManager/index.htm 参照

```ruby
class Cache
  attr_accessor :max, :pool

  def initialize
    @max = 2
    @pool = []
  end

  def fetch(key)
    v = nil
    if index = @pool.find_index {|e|e[:key] == key}
      v = @pool.slice!(index)[:val]
    else
      v = yield
    end
    @pool = ([:key => key, :val => v] + @pool).take(@max)
    v
  end
end

cache = Cache.new
cache.fetch(:a){1}              # => 1
cache.pool                      # => [{:key=>:a, :val=>1}]
cache.fetch(:b){1}              # => 1
cache.pool                      # => [{:key=>:b, :val=>1}, {:key=>:a, :val=>1}]
cache.fetch(:a){2}              # => 1
cache.pool                      # => [{:key=>:a, :val=>1}, {:key=>:b, :val=>1}]
cache.fetch(:c){1}              # => 1
cache.pool                      # => [{:key=>:c, :val=>1}, {:key=>:a, :val=>1}]
```

    a b で pool は b a の順になり、次の a で a b になり、次の c で c a b になる。
    が、キャッシュサイズは 2 なので b が死んで c a

** スレッド用

*** Single Threaded Execution

    排他制御のこと

```ruby
mutex = Mutex.new
a = 0
b = 0
2.times.collect do
  Thread.start do
    2.times do
      mutex.synchronize do
        a += 1
        Thread.pass
        b += 1
        p [a, b, (a == b)]
      end
    end
  end
end.each(&:join)
# >> [1, 1, true]
# >> [2, 2, true]
# >> [3, 3, true]
# >> [4, 4, true]
```

    明示的にパスしても synchronize ブロック内はスレッドが切り替わらないことがわかる。

*** Immutable

    スレッドから参照するオブジェクトの内容が変わる可能性があるなら排他制御が必要だけど、
    そのオブジェクトが不変(イミュータブル)ならば排他制御が必要がないということ。たぶん。

    Javaの本だとセッターがないものと書かれているけど、rubyの場合はreaderからreplaceすれば書き換えられるので気持ち程度にfreezeしてみた。

```ruby
class C
  attr_reader :v
  def initialize(v)
    @v = v
    @v.freeze
  end
end

a = C.new("x").freeze
a.v.replace("y") rescue $! # => #<RuntimeError: can't modify frozen String>
a.v += "y" rescue $!       # => #<NoMethodError: undefined method `v=' for #<C:0x007fbfc3903910 @v="x">>
a.v                        # => "x"
```

*** Guarded Suspention - 実行できるまで待つ

```ruby
queue = Queue.new

send_num = 10

sender = Thread.start do
  Thread.current[:data] = []
  send_num.times do |i|
    sleep(rand(0..0.01))
    queue << i
    Thread.current[:data] << i
  end
end

receiver = Thread.start do
  Thread.current[:data] = []
  send_num.times do
    sleep(rand(0..0.001))
    # pop出来ないとスレッドが自動停止してくれる。popだけどFIFO。間違いそう。
    Thread.current[:data] << queue.pop
  end
end

sender.join
receiver.join

# 正常にデータが受け取れているか確認
sender[:data]   # => [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
receiver[:data] # => [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
```

*** Worker Thread - 仕事がくるまで待ち仕事がきたら働く

```ruby
class Channel < SizedQueue
  attr_reader :threads

  def initialize(size)
    super(size)
    @threads = size.times.collect do |i|
      Thread.start(i) do |i|
        loop do
          request = pop
          p "スレッド#{i}が#{request}を担当"
          sleep(1)
        end
      end
    end
  end
end
```

    1つのワーカーだけだと 3.3 秒。(4秒になってないのは、たぶん最後の sleep(1) が開始した時点で status == "sleep" になってるから？)

```ruby
channel = Channel.new(1)
t = Time.now
4.times {|i|channel << i}
nil until channel.size.zero? && channel.threads.all?{|t|t.status == "sleep"}
puts "%.1f s" % (Time.now - t)
# >> "スレッド0が0を担当"
# >> "スレッド0が1を担当"
# >> "スレッド0が2を担当"
# >> "スレッド0が3を担当"
# >> 3.3 s
```

    4つのワーカーだと処理が分散してすぐ終わる

```ruby
channel = Channel.new(4)
t = Time.now
4.times {|i|channel << i}
nil until channel.size.zero? && channel.threads.all?{|t|t.status == "sleep"}
puts "%.1f s" % (Time.now - t)
# >> "スレッド1が0を担当"
# >> "スレッド0が1を担当"
# >> "スレッド3が2を担当"
# >> "スレッド2が3を担当"
# >> 0.8 s
```

*** Balking (ボーキング) - 実行できるまで待たない

    待つのではなく、すぐに *リターン* する。待つ場合は Guarded Suspention になる。
    一つのインスタンスの複数のスレッドで実行しているとき一部だけ排他制御を行うには synchronize ブロックで囲む。

    以下の例は a b c を順番に発動していく。
    ただ a の処理が 0.1 秒かかっているため、直後に発動した b は a が処理中のためリターンしている。
    aの処理が終わったころに発動した c は実行できていることがわかる。

```ruby
class C
  include Mutex_m

  def initialize
    super
    @change = false
  end

  def execute(str, t)
    synchronize do
      if @change
        p "処理中のため#{str}はスキップ"
        return
      end
      @change = true

      p str
      sleep(t) # sleepはsynchronizeの中で行わないとエラーになる

      @change = false
    end
  end
end

x = C.new
threads = []
threads << Thread.start {x.execute("a", 0.1)}
threads << Thread.start {x.execute("b", 0)}
sleep(0.1)
threads << Thread.start {x.execute("c", 0)}
threads.collect(&:join)
# >> "a"
# >> "処理中のためbはスキップ"
# >> "c"
```

*** Thread Per Message - 戻値不要

```ruby
def request(x)
  Thread.start(x){|x|p x}
end

request("a")
request("b")

(Thread.list - [Thread.main]).each(&:join)
# >> "a"
# >> "b"
```

*** Future - 戻値必要

```ruby
def request(x)
  Thread.start(x){|x|x}
end

t = []
t << request("A")
t << request("B")
t.collect(&:value) # => ["A", "B"]
```

*** Producer Consumer

    生産スレが作ってキューに入れて使用スレがpopする。
    SizedQueueのサイズの小さいほど流れが悪くなる。
    以下の例はSizedQueueのサイズが1しかないのでconsumerがpopしてくれないと次をpushできない。

```ruby
queue = SizedQueue.new(1)
producer = Thread.start {
  4.times {|i|
    p ["作成", i]
    queue.push(i)
  }
  p "作成側は先に終了"
}
consumer = Thread.start {
  4.times {
    p ["使用", queue.pop]
    sleep(0.01)
  }
}
producer.join
consumer.join
# >> ["作成", 0]
# >> ["作成", 1]
# >> ["使用", 0]
# >> ["作成", 2]
# >> ["使用", 1]
# >> ["作成", 3]
# >> ["使用", 2]
# >> "作成側は先に終了"
# >> ["使用", 3]
```

*** Read Write Lock

```ruby
class Buffer
  def initialize
    @sync = Sync.new
    @str = ""
  end

  def write(_str)
    @sync.synchronize(:EX) do
      _str.chars.with_index do |c, i|
        sleep(0.0001)
        @str[i] = c
      end
    end
  end

  def read
    @sync.synchronize(:SH) do
      @str.size.times.collect {|i|
        sleep(0.001)
        @str[i]
      }.join
    end
  end
end
```

    書き込みスレッドと、読み込みスレッドを並列で起動して、お互いが干渉するようにする

```ruby
buffer = Buffer.new
w = Thread.start do
  ("A".."Z").cycle {|c|
    buffer.write(c.to_s * 64)
    sleep(0.001)
  }
end
r = Thread.start do
  10.times do
    sleep(0.001)
    p buffer.read
  end
end
r.join
w.kill
```

    でも結果は壊れてない

```ruby
# >> "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
# >> "BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB"
# >> "CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC"
# >> "DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD"
# >> "EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE"
# >> "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF"
# >> "GGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGG"
# >> "HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH"
# >> "IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII"
# >> "JJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJ"
```

    @sync.synchronize ブロックを使わなかった場合

```ruby
# >> AAAAAAA
# >> BBBBBBBBBBCCCCCCCCCCCDDDDDDDDDDDEEEEEEEEEEEFFFFFFFFFFGGGGGGGGGGG
# >> IIIIIIIIIIJJJJJJJJJJJKKKKKKKKKKKLLLLLLLLLLMMMMMMMMMMMNNNNNNNNNNO
# >> PPPPPPPPPPQQQQQQQQQQQRRRRRRRRRRRSSSSSSSSSSTTTTTTTTTTTUUUUUUUUUUU
# >> WWWWWWWWWWXXXXXXXXXXXYYYYYYYYYYYYZZZZZZZZZZAAAAAAAAAAABBBBBBBBBB
# >> DDDDDDDDDDDEEEEEEEEEEEEFFFFFFFFFFFGGGGGGGGGGHHHHHHHHHHHIIIIIIIII
# >> JJKKKKKKKKKKKLLLLLLLLLLLMMMMMMMMMMNNNNNNNNNNNOOOOOOOOOOOPPPPPPPP
# >> QQRRRRRRRRRRRSSSSSSSSSSTTTTTTTTTTTUUUUUUUUUUVVVVVVVVVVVWWWWWWWWW
# >> XXYYYYYYYYYYYZZZZZZZZZZZAAAAAAAAAAABBBBBBBBBBBCCCCCCCCCCCDDDDDDD
# >> EEEEFFFFFFFFFFFGGGGGGGGGGGHHHHHHHHHHHIIIIIIIIIIIJJJJJJJJJJJKKKKK
```

*** Two Phase Termination

    外から Thread.kill するんじゃなくて止まるように指示

```ruby
t = Thread.start do
  2.times do |i|
    if Thread.current["interrupt"]
      break
    end
    p "処理中: #{i}"
    sleep(0.2)
  end
  p "終了処理"
end
sleep(0.1)
t["interrupt"] = true
t.join
# >> "処理中: 0"
# >> "終了処理"
```

*** Thread Specific Storage

    Thread.current["a"] はスレッド内グローバル変数

```ruby
Thread.start { Thread.current["a"] = 1 }.join
Thread.start { Thread.current["a"] }.value    # => nil
```

** その他

*** Active Object - 非同期メッセージを受け取る

    どんなときに有用か？

```ruby
class C
  def process
    1 + 2
  end
end

obj = C.new
obj.process
```

    ここで、すぐに実行する必要がない 1 + 2 の処理が重すぎる場合、

```ruby
class C
  attr_accessor :queue

  def initialize
    @queue = Queue.new
    Thread.start do
      loop { @queue.pop.call }  # バックグランド処理を永遠と回す
    end
  end

  def process
    @queue << proc {p 1 + 2}
  end
end

obj = C.new
obj.process

nil until obj.queue.empty?
```

    C#process の中の処理が変わっただけで *インタフェースはそのまま*

*** Before / After

```ruby
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
```

*** Pluggable Selector

    よくわかってない。
    一つのメソッドが巨大化しそうなときとかに、別のクラスを作るのが面倒という理由で似たような書き方をしてしまう。
    どうなんだろう？

```ruby
class C
  def initialize(command)
    @command = command
  end

  def execute
    send(@command)
  end

  def command_x
    :a
  end
end

C.new(:command_x).execute       # => :a
```

*** Object Pool

    メモ化というよりメモリと速度のトレードオフ。

```ruby
class X
  attr_accessor :active
end

class C
  attr_accessor :pool

  def initialize
    @size = 2
    @pool = []
  end

  def new_x
    x = @pool.find {|e|!e.active}  # pool から稼働してないものを探す
    unless x                      # なければ
      if @pool.size < @size       # pool の空きがあれば、新たに作成
        x = X.new
        @pool << x
      end
    end
    if x
      x.active = true
    end
    x
  end
end

i = C.new
a = i.new_x                  # => #<X:0x007fd1cb08d5c8 @active=true>
b = i.new_x                  # => #<X:0x007fd1cb08d140 @active=true>
c = i.new_x                  # => nil
a.active = false
c = i.new_x                  # => #<X:0x007fd1cb08d5c8 @active=true>
```

*** Null Object

```ruby
class Logger
  def info(str)
    str
  end
end

logger = Logger.new
logger.info("x")                # => "x"
```

    logger を無効にする

```ruby
class NullObject
  def info(str)
  end
end
```

```ruby
logger = NullObject.new
logger.info("x")                # => nil
```

    富豪的な感がよい
