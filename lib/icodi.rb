require 'victor'
require 'digest/md5'

class Icodi < Victor::SVGBase
  attr_reader :text, :options

  def initialize(text = nil, options = {})
    text, options = nil, text if text.is_a? Hash
    
    @text = text
    @options = default_options.merge options

    super template: template, viewBox: "0 0 #{size} #{size}", clip_path: "url(#rect)"
    
    generate
  end

  def method_missing(method_name, *_args, &_block)
    respond_to?(method_name) ? options[method_name] : super
  end

  def respond_to?(method_name, include_private = false)
    options.has_key?(method_name) ? true : super
  end

private

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

  def generate
    element :rect, x: 0, y: 0, width: size, height: size, fill: background
    element :defs do
      element :clipPath, id: :clipper do
        element :rect, width: size, height: size
      end
    end

    half = (pixels / 2.0).round
    x = mirror_x? ? half : pixels
    y = mirror_y? ? half : pixels

    element :g, clip_path: "url(#clipper)" do
      draw x, y
    end
  end  

  def draw(x_times, y_times)
    y_times.times do |y|
      x_times.times do |x|
        add_pixels x, y if random.rand < density
      end
    end
  end  

  def add_pixels(x, y)
    x, y = add_jitter x, y

    draw_pixel x, y
    draw_pixel mirror_value(x), y if mirror? x: x
    draw_pixel x, mirror_value(y) if mirror? y: y
    draw_pixel mirror_value(x), mirror_value(y) if mirror? x: x, y: y
  end

  def mirror?(x: nil, y: nil)
    if x and y
      mirror_both? and !mid?(x: x) and !mid?(y: y)
    elsif x
      mirror_x? and !mid? x: x
    elsif y
      mirror_y? and !mid? y: y
    end
  end

  def mid?(x: nil, y: nil)
    x ? x == pixels/2 : y ? y == pixels/2 : nil
  end

  def add_jitter(x, y)
    return [x, y] unless jitter > 0 and random(:jitter).rand < jitter
    
    x += [0, 0.5, -0.5][random(:jitter).rand(3)] unless mirror_x? and mid? x: x
    y += [0, 0.5, -0.5][random(:jitter).rand(3)] unless mirror_y? and mid? y: y
    [x, y]
  end

  def draw_pixel(x, y)
    element :rect, x: x*10, y: y*10, width: 10, height: 10, fill: color, style: style
  end

  def mirror_value(value)
    pixels - 1 - value
  end

end
