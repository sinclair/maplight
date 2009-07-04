require File.join( File.dirname(__FILE__), 'example_helper' )


describe 'MapLight::Bill', :focused=>false do
  
  describe "searching by name" do

    before(:each) do
      bill_data = '{ "bills": [ { "url": "http://maplight.org/map/us/bill/10400", "jurisdiction": "us", "session": "110", "prefix": "S", "number": "200", "measure": "S. 200 (110th) ", "topic": "Alaska Water Resources Act of 2007" } ] }'
      RestClient.stubs(:get).returns(bill_data) # expensive call 
      @bills = MapLight::Bill.search(:title=>'Water')
    end

    it 'should return a collection which is not empty when the search is successful' do
      @bills.should_not be_empty
    end
    
    it 'should return a collection of Bills with the seach criteria present in the #topic' do
      @bills.last().topic().should  include('Water')
    end 

    it 'should call the MapLight::Gateway' do
      MapLight::Gateway.expects(:get_bills_by_title).once.with('Water').returns({'bills'=>[]})
      MapLight::Bill.search(:title=>'Water')
    end
    
  end
  
end