# Flyweight - 同じ物を共有して無駄を無くす

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
