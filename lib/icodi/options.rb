module IcodiCore
  module Options
    def default_options
      {
        pixels:     5,
        density:    0.5,
        stroke:     0.1,
        background: '#fff',
        color:      random_color,
        mirror:     :x,
        jitter:     0,
        id:         :icodi,
      }
    end

    def background
      options[:background]
    end

    def color
      options[:color]
    end

    def density
      options[:density]
    end

    def id
      options[:id]
    end

    def jitter
      options[:jitter]
    end

    def mirror
      options[:mirror]
    end

    def mirror_x?
      %i[x both].include? mirror
    end

    def mirror_y?
      %i[y both].include? mirror
    end

    def mirror_both?
      mirror == :both
    end

    def pixels
      options[:pixels]
    end

    def size
      @size ||= pixels * 10
    end

    def stroke
      options[:stroke]
    end

    def style
      @style ||= { stroke: color, stroke_width: stroke }
    end
  end
end
