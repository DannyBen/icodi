require 'victor'
require 'digest/md5'

class Icodi < Victor::SVGBase
  attr_reader :text, :options

  def initialize(text = nil, options = {})
    text, options = nil, text if text.is_a? Hash
    @text, @options = text, options
    super template: template, viewBox: "0 0 #{size} #{size}"
    generate
  end

  def template
    options[:template] ||= :default
  end

  def pixels
    options[:pixels] ||= 5
  end

  def density
    options[:density] ||= 0.5
  end

  def stroke
    options[:stroke] ||= 1
  end

  def background
    options[:background] ||= '#fff'
  end

  def color
    options[:color] ||= "#%06x" % (random.rand * 0xffffff)
  end

  def mirror
    options[:mirror] ||= :x
  end

private

  def seed(string)
    Digest::MD5.hexdigest(string).to_i(16)
  end

  def random
    @random ||= (text ? Random.new(seed(text)) : Random.new)
  end

  def size
    @size ||= pixels * 10
  end

  def style
    @style ||= { stroke: color, stroke_width: stroke }
  end

  def mirror_x
    [:x, :both].include? mirror
  end

  def mirror_y
    [:y, :both].include? mirror
  end

  def mirror_both
    mirror == :both
  end

  def generate
    color # always randomize color first
    element :rect, x: 0, y: 0, width: size, height: size, fill: background
    half = (pixels / 2.0).round
    x = mirror_x ? half : pixels
    y = mirror_y ? half : pixels

    draw matrix x, y
  end  

  def draw(grid)
    grid.each_with_index do |row, y|
      row.each_with_index do |enabled, x|
        next unless enabled
        add_pixel x, y
        add_pixel pixels-1-x, y if mirror_x and x != pixels/2
        add_pixel x, pixels-1-y if mirror_y and y != pixels/2
        add_pixel pixels-1-x, pixels-1-y if mirror_both and x != pixels/2 and y != pixels/2
      end
    end
  end  

  def matrix(xtimes, ytimes)
    matrix = []
    ytimes.times do |y|
      matrix[y] = []
      xtimes.times do |x|
        matrix[y][x] = random.rand < density
      end
    end

    matrix
  end

  def add_pixel(x, y)
    element :rect, x: x*10, y: y*10, width: 10, height: 10, fill: color, style: style
  end
end
