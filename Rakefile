require 'rubygems'
require 'rake'
require 'echoe'

Echoe.new('alastrina', '0.0.1') do |p|
  # depends on twitter gem
  p.description    = "Tracks changes to models"
  p.url            = "http://github.com/medined/alastrina"
  p.author         = "David Medinets"
  p.email          = "david.medinets@gmail.com"
  p.ignore_pattern = ["tmp/*", "script/*"]
  p.development_dependencies = [ ]
end

Dir["#{File.dirname(__FILE__)}/lib/tasks/*.rake"].sort.each { |ext| load ext }
