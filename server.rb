require 'sinatra'
require 'icodi'

if development?
  require "sinatra/reloader"
  also_reload 'lib/icodi.rb'
end

set :bind, '0.0.0.0'
set :port, 3000

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

  content_type 'image/svg+xml'
  Icodi.new(seed, options).render
end