
module MapLight
  
  class Organization
    
    attr_accessor :name, :organization_id
    alias_method :id, :organization_id
    
    def initialize(params)
      params.each do |key, value|    
        instance_variable_set("@#{key}", value) if Organization.instance_methods.include? key
      end
      
    end
    
    def self.search(name)
      results = Gateway.new().get(:organization_search, :search=>name)
      results['organizations'].collect { |params| self.new(params) }
    end

  end

end
