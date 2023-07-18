require "pathname"
s = Pathname("a.txt").read
s = s.gsub(/```ruby/, "#+BEGIN_SRC")
s = s.gsub(/```$/, "#+END_SRC")
s = s.gsub(/^( *\*.*$)/, '# \1')
s = s.gsub(/^(#.*?#)$/, 'SEPRATOR\1')
s.split("SEPRATOR").each.with_index do |e, i|
  next if e == ""
  md = e.match(/#+\s+(.*?)\s+#+$/)
  title = md.captures.first
  fname = title
  fname = fname.gsub(/\s/, "_")
  fname = fname.gsub(/[()\/]/, "_")
  fname = fname.gsub(/-/, "_")
  fname = fname.gsub(/_+/, "_")
  fname = fname.gsub(/^_/, "")
  fname = fname.gsub(/_\z/, "")
  prefix = "%04d" % (i.next * 10)
  path = Pathname("#{prefix}_#{fname}.rb")
  puts path
  path.write(e)
end
