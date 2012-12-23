# -*- coding: utf-8 -*-
# Facade - シンプルな窓口

from = User.find_by_name("alice") || User.find_by_name("admin")
to = User.find_by_name!("bob")
transaction do
  message = Message.new(:date => Time.current)
  message.from = from
  message.to = to
  if message.valid?
    ...
  end
  message.save!
end

Message.deliver(:from => "alice", :to => "bob", :body => "hello")
