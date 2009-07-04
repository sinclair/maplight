require 'rubygems'
gem 'micronaut'
gem 'mocha'
require 'micronaut'
require 'mocha'

require File.join( File.dirname(__FILE__), '/../lib/maplight' )

MapLight.api_key= 'caee16151a22197259b754cdb09b18ac'

Micronaut.configure do |config|
  config.filter_run :focused => true
  config.alias_example_to :fit, :focused => true  
  config.color_enabled= true
  config.formatter= 'documentation'
  config.mock_with :mocha
end
