require 'cgi'

module MapLight

  API_VERSION= 'v1'
  BASE_URL = "http://maplight.org/services_open_api"
  DEFAULT_OUTPUT_FORMAT = 'json'
  
  attr_accessor :api_key
  module_function :api_key
  module_function :api_key=
  
  class ApiUrl

# {:api_method=>'', :api_method_params=>{...},  }
#
    def initialize(uri_parameters)
      @uri_parameters = uri_parameters
    end
    
    def to_s()
      "#{BASE_URL}/map.#{api_method()}_#{api_version()}.#{format()}?apikey=#{api_key()}&#{query_parameters_string()}"
    end
    
    def query_parameters_string(params=@uri_parameters[:query_params])
      params.collect { |k, v|
        "#{k.to_s()}=#{CGI.escape( v.to_s() )}"
      }.join('&')
    end

    def format()
      DEFAULT_OUTPUT_FORMAT || @uri_parameters[:api_version]
    end
    
    def api_method()
      # DEBT
      @uri_parameters[:api_method] || 'organization_search'
    end
    
    def api_version()
      API_VERSION || @uri_parameters[:api_version]
    end
    
    def api_key()
      MapLight.api_key()
    end
    
  end


  class Client

    def initialize(client=RestClient)
      @client= client
    end

    def get(url)
#puts "---- #{url}"
      @client.get(url)
    end

  end


  class ResponseParser

    def initialize(parser=JSON)
      @parser= parser
    end

    def parse(gateway_response_string)
#puts "++++ #{gateway_response_string}"
      @parser.parse(gateway_response_string)
    end

  end


  class Service

    def initialize(http_client=Client.new(), data_parser=ResponseParser.new())
      @service_client = http_client
      @response_parser = data_parser
    end
    
    def get(url)
      response_data = @service_client.get(url)
      @response_parser.parse(response_data)
    end
    
  end
 
  
  class Gateway
    
    def initialize(params={})
      @service_client = params[:gateway_client] || Client.new()
      @response_parser = params[:response_parser] || ResponseParser.new()
    end

    def get(method_name, params)
      @api_url = ApiUrl.new( {:api_method=>method_name, :api_version=>'v1'}.merge(:query_params=>params) )

      @response_parser.parse( @service_client.get(@api_url.to_s()) )
    end

    def self.get_organization_positions(organization_id)
      url = "#{BASE_URL}/map.organization_positions_v1.json?apikey=#{MapLight.api_key()}&organization_id=#{organization_id}"
      call_service_api(url)
    end
    
    def self.get_bills_by_title(title_word)
      url = "#{BASE_URL}/map.bill_search_v1.json?apikey=#{MapLight.api_key()}&jurisdiction=us&search=#{CGI.escape(title_word)}"
      call_service_api(url)
    end

    private
      def self.call_service_api(url)
        Service.new().get(url)
      end
    
    private
          
      def default_search_criteria(override={})
        @default_search_criteria ||= {:format=>api_response_format(), :api_version=>api_version()}
      end
      
      def api_key()
        MapLight.api_key()
      end
      
      def api_version()
        MapLight.API_VERSION
      end
      
      def api_response_format()
        MapLight.DEFAULT_OUTPUT_FORMAT
      end
      alias_method :format, :api_response_format
    
  end
  
end

