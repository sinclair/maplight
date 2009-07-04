require 'spec/expectations'
require 'cucumber/formatter/unicode'
require File.join( File.dirname(__FILE__), '..', '..', 'lib', 'maplight' )

# load the api key 
if File.exists?( apikey = File.join( File.dirname(__FILE__), '../..', 'api_key.rb') ) then
  require apikey
end
