require 'simplecov'
require 'bundler'

SimpleCov.start { enable_coverage :branch }
Bundler.require :default, :development
