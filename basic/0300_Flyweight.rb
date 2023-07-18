## Flyweight ##

#+BEGIN_SRC
module Sound
  class << self
    def fetch(name)
      @cache ||= {}
      @cache[name] ||= load("#{name}.mp3")
    end

    private

    def load(name)
      rand
    end
  end
end

Sound.fetch(:battle) # => 0.20421287695439794
Sound.fetch(:battle) # => 0.20421287695439794
#+END_SRC

# * メモ化で効率化すること
# * Immutable にすることが多い
# * Immutable な点から見れば Value Object な役割りになっていることもある

