# http://maplight.org/services_open_api/map.bill_positions_v1.json?apikey=caee16151a22197259b754cdb09b18ac&jurisdiction=us&session=111&prefix=hr&number=1
# http://maplight.org/services_open_api/map.bill_positions_v1.json?apikey=caee16151a22197259b754cdb09b18ac&jurisdiction=ca&session=2003&prefix=AB&number=1156
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
        instance_variable_set( "@#{key}".to_sym(), value ) if Bill.instance_methods.include? key.to_s()
      end
    end
    
    def positions()
      @positions ||= MapLight::Position.search_bill_positions( self.positions_search_parameters() )
    end

    def positions_search_parameters()
      {:jurisdiction=>@jurisdiction, :session=>@session, :prefix=>@prefix, :number=>@number}
    end
  end

end