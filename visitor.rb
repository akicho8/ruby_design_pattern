require "pathname"

Pathname.glob("**/*.rb") do |filename|
  p filename
end
