
# encoding: utf-8
require 'spec/expectations'
#$:.unshift(File.dirname(__FILE__) + '/../lib') # This line is not needed in your own project
require 'cucumber/formatter/unicode'
require File.join( File.dirname(__FILE__), '..', '..', 'lib', 'maplight' )

Given /that I have registered and received a MapLight api key from maplight.org/ do
end

Given /^that my MapLight api key has been set$/ do
  MapLight.api_key= 'caee16151a22197259b754cdb09b18ac'
end

Given /^that the MapLight module has been included$/ do
  include MapLight
end

When /^searching for all organizations with (.*) in their name$/ do |name|
  @organizations = MapLight::Organization.search(name)
end

Then /^the result should contain at least one Organization$/ do
  @organizations.should_not be_empty
end

Then /^the result should contain no Organization$/ do
  @organizations.should be_empty
end
