require 'rubygems'
require File.join( File.dirname(__FILE__), 'example_helper' )

describe 'Organization' do

  describe 'when initializing' do
    before(:each) do
      @instantiation_params={"name"=>"Glasgow Bail Bonds", "organization_id"=>"8469"}
      @organization = MapLight::Organization.new(@instantiation_params)
    end
    
    it 'should create an new instance without an error' do
      lambda { MapLight::Organization.new(@instantiation_params)
        }.should_not raise_error
    end
    
    it 'should initialize from the creation parameters' do
      @organization.name.should == @instantiation_params['name']
      @organization.organization_id.should == @instantiation_params['organization_id']
    end
    
  end
  
  describe 'searching for the id' do

    it 'should return an empty result set when not successful', :pending=>true do
      MapLight::Organization.all_for( :name=>'test com' ).should == []
    end
    
    it 'should return an array of Organizations when there is a match on name', :pending=>true do
#      "http://maplight.org/services_open_api/map.organization_search_v1.json?apikey=#{MAPLIGHT_API_KEY}&search=#{NAME}"
      MapLight::Organization.all_for().should include( kind_of?(MapLight::Organization) )
    end

  end

end

# describe "Metadata support in Micronaut" do
#   
#     it "this will definitely run", :focused => false do
#       self.running_example.metadata[:focused].should == true
#     end
# 
#     it "this never runs" do
#       raise "shouldn't run while other specs are focused"
#     end
# 
#     it "this is also focused via the fit alias" do
#       true.should_not == false
#     end
# 
#     it "this won't run, its pending", :pending => true do
#     end
# 
#     it "this is also pending, with the no block style"
# 
#     it "this spec takes *real* long and should only run when we want to take the hit of slow specs", :speed => "slow" do
#       sleep(10000)
#       2+2.should == 4
#     end
# end