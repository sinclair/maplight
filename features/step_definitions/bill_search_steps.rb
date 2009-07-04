require 'spec/expectations'
require 'cucumber/formatter/unicode'
require File.join( File.dirname(__FILE__), '..', '..', 'lib', 'maplight' )

#bills_json = '{ "bills": [] }'
#RestClient.stubs(:get).returns(bills_json

When /^searching for all bills with (.*) in their name$/ do |search_string|
  @bills = MapLight::Bill.search(:title=>search_string)
end

Then /^the result should contain at least one LegislativeBill$/ do
  @bills.should_not be_empty
end