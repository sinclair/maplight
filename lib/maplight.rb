require 'rubygems'
require 'json'
require 'rest_client'

Dir["#{File.dirname(__FILE__)}/maplight/*.rb"].each { |source_file| 
  require source_file
}
