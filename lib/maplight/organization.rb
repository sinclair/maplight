module MapLight
  
  class Organization
        
    attr_accessor :name, :organization_id
    alias_method :id, :organization_id
    
    def initialize(params)
      params.each do |key, value|    
        instance_variable_set( "@#{key}".to_sym(), value ) if Organization.instance_methods.include? key.to_s()
      end
      
    end
    
    def self.search(name)
      results = Gateway.new().get(:organization_search, :search=>name)
      results['organizations'].collect { |params| self.new(params) }
    end
    
    def positions()
      #http://maplight.org/services_open_api/map.organization_positions_v1.json?apikey=example&organization_id=22135
      MapLight::Position.search( organization_id() )
    end
    
  end
  
end
