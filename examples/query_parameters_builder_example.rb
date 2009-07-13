require File.join( File.dirname(__FILE__), 'example_helper' )

describe MapLight::QueryParametersBuilder, :focused=>false do

  it 'should return an a string containing the parameters' do
    query_parameters = {:param1=>1, :param2=>'2'}
    query_parameters_string = MapLight::QueryParametersBuilder.new('test-key').to_s(query_parameters)
    query_parameters_string.should include('apikey=test-key')
    query_parameters_string.should include('param1=1')
    query_parameters_string.should include('param2=2')
    query_parameters_string.should include('&')      
  end

  it 'should return omit nil parameter values' do
    query_parameters = {:param=>nil}
    query_parameters_string = MapLight::QueryParametersBuilder.new('zz').to_s(query_parameters)
    query_parameters_string.should include('apikey=zz')
    query_parameters_string.should_not include('param')
    query_parameters_string.should_not include('&')      
  end

  it 'should handle no query parameters' do
    query_parameters = {}
    query_parameters_string = MapLight::QueryParametersBuilder.new('zz').to_s(query_parameters)
    query_parameters_string.should include('apikey=zz')
    query_parameters_string.should_not include('&')      
  end

end