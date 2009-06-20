module MapLight
  
  class Gateway

    def initialize()
      @maplight_api_key= MAPLIGHT_API_KEY  
      @url_base= "http://maplight.org/services_open_api"
      @gateway_client = Client.new()
      @response_parser = ResponseParser.new()
    end

    def get_organization_position(id= '22135')
      url = "#{@url_base}/map.organization_positions_v1.json?apikey=#{@maplight_api_key}&organization_id=#{id}"
      response_string = @gateway_client.get(url)
      @response_parser.parse(response_string)
    end

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

