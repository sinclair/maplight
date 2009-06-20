require 'rubygems'
gem 'micronaut'
require 'micronaut'

require File.join( File.dirname(__FILE__), '/../lib/maplight' )

Micronaut.configure do |config|
  config.filter_run :focused => true
  config.alias_example_to :fit, :focused => true  
  config.color_enabled= true
  config.formatter= 'documentation'
end
