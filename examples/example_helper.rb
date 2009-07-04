require 'rubygems'
gem 'micronaut'
gem 'mocha'
require 'micronaut'
require 'mocha'

require File.join( File.dirname(__FILE__), '/../lib/maplight' )
if File.exists?( apikey = File.join( File.dirname(__FILE__), '..', 'api_key.rb') ) then
  require apikey
end

Micronaut.configure do |config|
  config.filter_run :focused => true
  config.alias_example_to :fit, :focused => true  
  config.color_enabled= true
  config.formatter= 'documentation'
  config.mock_with :mocha
end
