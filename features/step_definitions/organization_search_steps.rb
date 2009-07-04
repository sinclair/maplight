#positions_json = '{ "organizations": [ { "name": "Glasgow Bail Bonds", "organization_id": "22135"}, {"name": "US Bail Bonds", "organization_id": "11011" } ] }'
#RestClient.stubs(:get).returns(positions_json)

Given /that I have registered and received a MapLight api key from maplight.org/ do
end

Given /^that my MapLight api key has been set$/ do
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
