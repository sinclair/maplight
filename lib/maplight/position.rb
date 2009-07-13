module MapLight
  
  class Position

    def self.search(organization_id)
      MapLight::Gateway.get_organization_positions( organization_id )['positions'].collect do |position_data|
        self.new(position_data)
      end
    end

    def self.search_bill_positions(search_parameters)
      MapLight::Gateway.get_bill_positions(search_parameters)['bill'].collect do |position_data|
        self.new(position_data)
      end
    end

    attr_reader :citation, :prefix, :session, :topic, :url, :disposition
    
    def initialize(params)
      params.each do |key, value|    
        instance_variable_set( "@#{key}".to_sym(), value ) if Position.instance_methods.include? key.to_s()
      end
    end
    
  end

end