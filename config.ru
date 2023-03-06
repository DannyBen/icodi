# Icodi Server Sinatra Example
#
# Download this config.ru file, then start the server with:
#
#   $ rackup -p 3000 -o 0.0.0.0
#
# Then render some images in your browser:
#
# - http://localhost:3000
# - http://localhost:3000/you@your-email.com
# - http://localhost:3000/you@your-email.com?pixels=5&jitter=0.5

require 'sinatra'
require 'icodi'

get '/*' do
  seed = params[:splat].first
  seed = nil if seed.empty?

  options = {}
  options[:pixels]     = params[:pixels].to_i if params[:pixels]
  options[:stroke]     = params[:stroke].to_f if params[:stroke]
  options[:density]    = params[:density].to_f if params[:density]
  options[:mirror]     = params[:mirror].to_sym if params[:mirror]
  options[:jitter]     = params[:jitter].to_f if params[:jitter]
  options[:background] = "##{params[:background]}" if params[:background]
  options[:color]      = "##{params[:color]}" if params[:color]

  content_type :svg
  Icodi.new(seed, options).render
end

run Sinatra::Application
