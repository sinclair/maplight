require File.join( File.dirname(__FILE__), 'example_helper' )


describe MapLight::Bill do
  
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
  
  describe 'searching for organization positions on a bill' do

    before(:each) do
      @bill_json = '{ "bill": { "url": "http://maplight.org/map/us/bill/79075", "last_update": "2009-03-18T22:11:01Z", "organizations": [  ] } }'
    end

    it 'should call the bill positions search with the search parameters' do
      RestClient.stubs(:get).returns(@bill_json)
      @bill=MapLight::Bill.new(:jurisdiction=>'us', :session=>111, :prefix=>'hr', :number=>1)
      @bill.positions()
    end
    
    it 'should return a bill position search parameters' do
      @bill=MapLight::Bill.new(:jurisdiction=>'us', :session=>111, :prefix=>'hr', :measure=>'not me')
      @bill.positions_search_parameters().keys().should include(:jurisdiction, :prefix, :prefix, :number)
      @bill.positions_search_parameters().keys.should_not include(:measure)
      @bill.positions_search_parameters()[:jurisdiction].should == 'us'
      @bill.positions_search_parameters()[:session].should == 111
      @bill.positions_search_parameters()[:prefix].should == 'hr'
      @bill.positions_search_parameters()[:number].should be_nil
    end
    
  end
  
end