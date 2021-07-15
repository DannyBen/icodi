require 'victor'
require 'digest/md5'
require 'icodi/option_handling'
require 'icodi/randomization'

class Icodi < Victor::SVGBase
  include IcodiCore::OptionHandling
  include IcodiCore::Randomization

  attr_reader :text, :options

  def initialize(text = nil, opts = {})
    text, opts = nil, text if text.is_a? Hash
    
    @text = text
    @options = default_options.merge opts

    super template: template, viewBox: "0 0 #{size} #{size}", id: id
    
    generate
  end

private

  def generate
    clip_path_id = "#{id}-#{random_id}"

    element :rect, x: 0, y: 0, width: size, height: size, fill: background
    element :defs do
      element :clipPath, id: clip_path_id do
        element :rect, width: size, height: size
      end
    end

    half = (pixels / 2.0).round
    x = mirror_x? ? half : pixels
    y = mirror_y? ? half : pixels

    element :g, clip_path: "url(##{clip_path_id})" do
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

  def add_jitter(x, y)
    if jitter > 0 and random(:jitter).rand < jitter
      add_jitter! x, y
    else
      [x, y] 
    end
  end

  def add_jitter!(x, y)
    x += random_jitter unless mirror_x? and mid? x: x
    y += random_jitter unless mirror_y? and mid? y: y
    [x, y]
  end

  def draw_pixel(x, y)
    element :rect, x: x*10, y: y*10, width: 10, height: 10, fill: color, style: style
  end

  # Drawing Utilities

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

  def mirror_value(value)
    pixels - 1 - value
  end

  def random_id
    random(:nonvisual).rand(9999999)
  end

  def random_jitter
    [0, 0.5, -0.5][random(:jitter).rand(3)]
  end

  def random_color
    "#%06x" % (random(:color).rand * 0xffffff)
  end

end
