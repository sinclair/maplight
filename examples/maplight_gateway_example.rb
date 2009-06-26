require File.join( File.dirname(__FILE__), 'example_helper' )

describe 'MapLight::Gateway' do

  describe 'when processing an unsuccessful get' do

    it 'should return an empty collection' do
      RestClient.stubs(:get).returns('{ "organizations": [] }' )
      MapLight::Gateway.new().get(:organization_search, :search=>'woohoo')['organizations'].should be_empty
    end

  end


end
