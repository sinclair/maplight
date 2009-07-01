# encoding: utf-8
require 'spec/expectations'
#$:.unshift(File.dirname(__FILE__) + '/../lib') # This line is not needed in your own project
require 'cucumber/formatter/unicode'
require File.join( File.dirname(__FILE__), '..', '..', 'lib', 'maplight' )

positions_json = '{ "positions": [ { "url": "http://maplight.org/map/us/bill/52909", "disposition": "support", "jurisdiction": "US", "session": "110", "prefix": "H", "number": "1851", "measure": "H.R. 1851 (110th) ", "topic": "Section 8 Voucher Reform Act of 2007", "citation": " (n.d.). \x3ccite\x3eNational Association of Realtors; \x26quot;House Committee Passes Three Housing Bills\x26quot;; Megan Booth; 5-28-07\x3c/cite\x3e. Retrieved n.d., from  Web site: \x3ca href=\"\"\x3e\x3c/a\x3e." }] }'
RestClient.stubs(:get).returns(positions_json)

Given /^an organization$/ do
  MapLight.api_key= 'caee16151a22197259b754cdb09b18ac'
  include MapLight
  @organization = MapLight::Organization.new(:name=>'Glasgow Bail Bonds', :organization_id=>22135)
end

When /^I invoke the positions method$/ do
  @positions = @organization.positions()
end

When /^calling the web service positions search api$/ do
end

Then /^the system should return all the positions for that organization$/ do
  @positions.should_not be_empty
end
