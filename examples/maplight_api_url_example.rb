require 'rubygems'
require File.join( File.dirname(__FILE__), 'example_helper' )

describe 'MapLight::ApiUrl' do
  include MapLight

  describe 'when initializing' do
    
    it 'should return a new instance' do
      MapLight::ApiUrl.new({}).should_not be_nil
    end
    
    it 'should accept uri element parameters', :pending=>true do
      MapLight::ApiUrl.new({:search=>'name'}).should_not raise_error
    end
    
  end

  describe 'when creating the query parameters', :focused=>false do
    MapLight.api_key= 'keynumber1'

    before(:each) do
      @query_params = {:search=>'glasgow', :exact=>1}
      @query_param_string = MapLight::ApiUrl.new({}).query_parameters_string(@query_params)
    end
      it 'should include the MapLight api key', :pending=>true do
        @query_param_string.should =~ /keynumber1/
      end

      it 'should create a query parameter string' do
        ['search=glasgow&exact=1','exact=1&search=glasgow'].should include @query_param_string
      end
      
      it 'should escape the values' do
        MapLight::ApiUrl.new({}).query_parameters_string({:a=>'hoy and boy'}).should == 'a=hoy+and+boy'
      end
    
  end
  
  describe 'when creating the core uri string (minus the query parameters)' do
    
    before(:each) do
      @query_params = {}
      @api_url_string = MapLight::ApiUrl.new(@query_params).to_s()
    end
    
    it 'should include the response format' do
      @api_url_string.should =~ /json/
    end
    
    it 'should include the api version' do
      @api_url_string.should =~ /v1/
    end
    
    
  end
  
end
