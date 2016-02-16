# Hace require de los gems necesarios.
# Revisa: http://gembundler.com/bundler_setup.html
#      http://stackoverflow.com/questions/7243486/why-do-you-need-require-bundler-setup
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

# Require gems we care about
require 'rubygems'

require 'uri'
require 'pathname'

require 'pg'
require 'active_record'
require 'logger'

require 'sinatra'
require "sinatra/reloader" if development?

require 'erb'

require 'bcrypt'

# Configuración para fotos
require 'carrierwave'
require 'carrierwave/orm/activerecord'
require 'mini_magick'



APP_ROOT = Pathname.new(File.expand_path('../../', __FILE__))

APP_NAME = APP_ROOT.basename.to_s

# Configura los controllers y los helpers
Dir[APP_ROOT.join('app', 'controllers', '*.rb')].each { |file| require file }
Dir[APP_ROOT.join('app', 'helpers', '*.rb')].each { |file| require file }
Dir[APP_ROOT.join('app', 'uploaders', '*.rb')].each { |file| require file }
# Revisa que el folder de uploaders este contemplado el la configuración del app
Dir[APP_ROOT.join('app', 'uploaders', '*.rb')].each { |file| require file }

#Configuración global de todos los uploaders de CarrierWave
CarrierWave.configure do |config|
  config.root = APP_ROOT + 'public/'
end
# Configura la base de datos y modelos 
require APP_ROOT.join('config', 'database')


