require File.join( File.dirname(__FILE__), 'example_helper' )


describe 'Organization', :focused=>false do
    
  describe 'when searching by name'do
    
    before(:each) do
      RestClient.stubs(:get).returns( "[{:name=>'Glasgow Bail Bonds', :organization_id=>'1234'}]" )
    end


    it 'should return a collection of Organizations when the search is successful' do
      RestClient.expects(:get).once().with( regexp_matches(/search\=glasgow$/) ).returns( '{ "organizations": [ { "organization_id": "8469", "name": "Glasgow Bail Bonds" } ] }'  )
      MapLight::Organization.search('glasgow')[0].class.should == MapLight::Organization
    end

    it 'should return an empty result when the search is unsuccessful'  do
      RestClient.expects(:get).once().returns( '{ "organizations": [  ] }'  )
      MapLight::Organization.search('no_org_to_be_found').should be_empty
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


  describe 'positions retrieval', :focused=>false do
    before(:all) do
      @position_data= {'positions'=>
        {"citation"=>" (n.d.). x3ccitex3e2008.01.22 H.R. 3959 NAR Letter Opposingx3c/citex3e. Retrieved n.d., from  Web site: x3ca href=""x3ex3c/ax3e.", 
          "prefix"=>"H", "measure"=>"H.R. 3959 (110th) ", "jurisdiction"=>"US", "number"=>"3959", 
          "topic"=>"To amend the National Flood Insurance Act of 1968 to provide for the phase-in of actuarial rates for certain pre-FIRM properties", 
          "session"=>"110", 
          "url"=>"http://maplight.org/map/us/bill/72584", 
          "disposition"=>"oppose"}}      
    end
    
    before(:each) do
      @organization = MapLight::Organization.new(:name=>'Test this inc.', :organization_id=>22135)
    end
    
    it 'should return a collection of at least one when successful' do
      @organization.positions().should_not be_empty
    end
    
    it 'should instantiate a Position' do
      @organization.positions[0].class.should == MapLight::Position    
    end
    
    it 'should call the MapLight::Gateway to retrieve the Positions' do
      MapLight::Gateway.expects(:get_organization_positions).once.with(22135).returns(@position_data)
      @organization.positions()
    end
  end
end

