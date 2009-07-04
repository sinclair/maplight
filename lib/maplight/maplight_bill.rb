module MapLight

  class Bill
    
    def self.search(search_params)
      MapLight::Gateway.get_bills_by_title(search_params[:title])['bills'].collect do |bill_data|
        self.new(bill_data)
      end
    end

    attr_reader :jurisdiction, :measure, :number, :prefix, :session, :topic, :url

    def initialize(params)
      params.each do |key, value|    
        instance_variable_set( "@#{key}".to_sym(), value ) if Position.instance_methods.include? key.to_s()
      end
    end
    

  end

end