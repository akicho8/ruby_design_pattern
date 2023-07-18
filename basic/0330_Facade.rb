## Facade ##

# こんなのをあっちこっちに書かせるんじゃなくて

# ```ruby
# message = Message.new(date: Time.now)
# message.from = User.find_by(name: "alice")
# message.to   = User.find_by(name: "bob")
# message.body = "..."
# if message.valid?
#   message.save!
# end
# MessageMailer.message_created(message).deliver_later
# ```

# こんな風に簡単に使えるようにしとけってこと

# ```ruby
# Message.deliver(from: "alice", to: "bob", body: "...")
# ```
