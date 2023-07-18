# ---
# title: "Rubyで書くデザインパターン"
# emoji: "🍅"
# type: "tech" # tech: 技術記事 / idea: アイデア
# topics: ["Ruby", "デザインパターン"]
# published: true
# ---

## 概略 ##

##### Template Method 系 #####

# | 名前            | 概要                                                          |
# |-----------------+---------------------------------------------------------------|
# | Template Method | initialize に書けば最初に実行されると決まっているそういうやつ |
# | Abstract Class  | Ruby だとあまり利点がない Template Method 風なやつ            |
# | Factory Method  | new を別オブジェクトが行うだけ(？)                            |

##### Singleton 系 #####

# | 名前                             | 概要                                             |
# |----------------------------------+--------------------------------------------------|
# | Singleton                        | インスタンスをグローバル変数にしたいとき用       |
# | Monostate                        | new できるけど状態は共有                         |
# | Single-Active-Instance Singleton | 複数あるインスタンスのなかで一つだけが有効になる |

##### リファクタリング(?) #####

# | 名前            | 概要                                                       |
# |-----------------|------------------------------------------------------------|
# | Composed Method | 巨大なメソッドを分割する。リファクタリングの第一歩   |
# | Adapter         | ダメなインターフェイスをいろんな手段で隠す                 |
# | Value Object    | 値をクラス化する。Immutable にする                         |

##### メモ化 #####

# | 名前      | 概要                                 |
# |-----------+--------------------------------------|
# | Flyweight | 効率化を目的とする。Immutable が多い |
# | Sharable  | データの一貫性を目的とする。Mutable  |

##### Imposter #####

# | 名前        | 概要                                                   |
# |-------------+--------------------------------------------------------|
# | Null Object | データ不在を存在するかのように扱う。条件分岐したら負け |
# | Composite   | 集合を単体のように扱う                                 |

# * Imposter には「偽物」「詐欺師」の意味がある
# * Imposter は「振りをする」パターンの総称と思われる

##### その他 (分類を諦めた) #####

# | 名前                    | 概要                                                               |
# |-------------------------+--------------------------------------------------------------------|
# | Strategy                | 挙動を他のクラスに任せる (外から明示的に)                          |
# | State                   | 挙動を他のクラスに任せる (内でこっそり) 3択以上が多い              |
# | Pluggable Object        | State と同じ。冗長なif文を改善した直後の、2択の State なことが多い |
# | Observer                | 仲介して通知する。一方通行であること                               |
# | Component Bus           | Observer が Subject を握っている                                   |
# | Iterator                | each のこと                                                        |
# | Prototype               | new ではなく clone で                                              |
# | Builder                 | xml.body { xml.p("x") } みたいなやつとかいろいろ                   |
# | Abstract Factory        | クラスをハードコーディングしない                                   |
# | Decorator               | 元のクラスを汚したくない潔癖症な人向け                             |
# | Visitor                 | Pathname.glob("*.rb") {...}                                        |
# | Chain of Responsibility | resolve? なら受ける。(順にリンクしてないといけないか疑問)          |
# | Facade                  | 単にメソッド化？                                                   |
# | Mediator                | A と B で困ったら Mediator クラスが必要                            |
# | Memento                 | 前の状態に戻りたいとき用                                           |
# | Proxy                   | すり替えて、呼んだり呼ばなかったり、まねたり、あとで呼ぶ           |
# | Command                 | 命令をクラスにする。migrate のあれ。お気に入り。                   |
# | Policy                  | Command パターンで複雑な条件の組み合わせをほぐす                   |
# | Interpreter             | 文法規則をクラスで表現                                             |
# | DSL                     | ドメイン特化言語                                                   |
# | Object Pool             | 生成に時間がかかるものを使い回す                                   |
# | Pluggable Selector      | 横着ポルモルフィック                                               |
# | Before / After          | 後処理を必ず実行                                                   |
# | Bridge                  | よくわからない。クラスが増えないようにする                         |
# | Typed Message           | GUI でよくある Event::Mouse::Click みたいなあれ                    |
# | Cache Manager           | 使ったキャッシュは先頭に移動する                                   |
# | Marker Interface        | 印付けとしてのインターフェイスというかモジュール？                 |
# | Generation Gap          | ソースコードジェネレーターは親クラスだけ再生成する                 |
# | Hook Operation          | 実行処理の前後に何かを実行できるようにしておく                     |
# | Collecting Parameter    | 結果を集める                                                       |
# | First Class Collection  | だいたい Value Object と同じで配列をラップする                     |
