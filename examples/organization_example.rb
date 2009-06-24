require File.join( File.dirname(__FILE__), 'example_helper' )


describe 'Organization' do
    
  describe 'when searching by name', :focused=>false do
    
    before(:each) do
      RestClient.stubs(:get).returns( "[{:name=>'Glasgow Bail Bonds', :organization_id=>'1234'}]" )
    end


    it 'should call the gateway with the name to use in the search' do
      RestClient.expects(:get).once().with( regexp_matches(/search\=glasgow$/) ).returns( '{ "organizations": [ { "organization_id": "8469", "name": "Glasgow Bail Bonds" } ] }'  )
      MapLight::Organization.search('glasgow')[0].class.should == MapLight::Organization
    end
  end
  
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

