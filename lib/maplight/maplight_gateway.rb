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
      "#{BASE_URL}/map.#{api_method()}_#{api_version()}.#{format()}?apikey=#{api_key()}&search=#{'glasgow'}"
    end
    
    def query_parameters_string(params=@uri_parameters)
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
  
  class Gateway
    
    def initialize(params={})
      @service_client = params[:gateway_client] || Client.new()
      @response_parser = params[:response_parser] || ResponseParser.new()
    end

    def get(method_name, params)
      @api_url = ApiUrl.new( {:api_method=>method_name, :api_version=>'v1'}.merge(params) )
      @response_parser.parse( @service_client.get(@api_url.to_s()) )
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
  
  class Client

    def initialize(client=RestClient)
      @client= client
    end

    def get(url)
      @client.get(url)
    end

  end
  
  class ResponseParser

    def initialize(parser=JSON)
      @parser= parser
    end

    def parse(gateway_response_string)
      @parser.parse(gateway_response_string)
    end

  end
  
end

