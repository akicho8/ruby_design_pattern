# Two-Phase Terminatin

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
