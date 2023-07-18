## Prototype ##

# クラスが無い言語で無理矢理クラスっぽくする

A = {
  first: "Alice",
  last:  "Smith",
  name:  -> c { [c[:first], c[:last]] * " " },
}
A[:name][A]     # => "Alice Smith"

# 継承する

B = A.clone
B[:first] = "Bob"
B[:name][B]     # => "Bob Smith"

# クラスのある言語でもオブジェクト生成時のコストが高い場合には有用なのかもしれない
