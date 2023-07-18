## Visitor ##

#+hidden: true
require "pathname"

#+BEGIN_SRC
Pathname.glob("**/*.rb") { |e| e }
#+END_SRC

# 汎用性のある渡り歩く処理と、汎用性のない利用者側の処理を分ける
