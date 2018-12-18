module IcodiCore
  module Randomization

    def random_color
      "#%06x" % (random(:color).rand * 0xffffff)
    end

    def seed(string)
      Digest::MD5.hexdigest(string).to_i(16)
    end

    def random(set = nil)
      @random_sets ||= {}
      set ||= :default
      @random_sets[set] ||= (text ? Random.new(seed(text)) : Random.new)
    end

  end
end