module IcodiCore
  module OptionHandling

    def method_missing(method_name, *_args, &_block)
      respond_to?(method_name) ? options[method_name] : super
    end

    def respond_to?(method_name, include_private = false)
      options.has_key?(method_name) ? true : super
    end

    def default_options
      {
        template: :default, 
        pixels: 5,
        density: 0.5,
        stroke: 0.1,
        background: '#fff',
        color: random_color,
        mirror: :x,
        jitter: 0,
      }
    end

    # Derivative Properties

    def size
      @size ||= pixels * 10
    end

    def style
      @style ||= { stroke: color, stroke_width: stroke }
    end

    def mirror_x?
      [:x, :both].include? mirror
    end

    def mirror_y?
      [:y, :both].include? mirror
    end

    def mirror_both?
      mirror == :both
    end

  end
end