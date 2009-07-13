#bill_json = '{ "bill": [] }'
#RestClient.stubs(:get).returns(bill_json)

When /^searching for all bills with (.*) in their name$/ do |search_string|
  @bills = MapLight::Bill.search(:title=>search_string)
end

Then /^the result should contain at least one LegislativeBill$/ do
  @bills.should_not be_empty
end

When /^getting the positions for the bill$/ do
  @bill_positions = @bill.positions()
end

Then /^the result should contain a list of positions$/ do
  @bill_positions.should_not be_empty
  @bill_positions[0].class.should == MapLight::Position
end

Given /^that I have a bill$/ do
  @bill=MapLight::Bill.new(:jurisdiction=>'us', :session=>111, :prefix=>'hr', :number=>1)
end
