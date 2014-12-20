class MarketData
  attr_reader(:system, :station, :commodities)
  
  def initialize(system, station)
    @commodities = []
    @system = system
    @station = station
  end
  
  def add_commodity(name, sell="", buy="", demand=0, demandLevel="", supply=0, supplyLevel="")
    if name.nil?
      raise "Commodity name cannot be null"
    end
    puts "Buy: #{buy}"
    @commodities << { 
                      :name => name, 
                      :sell => sell.nil? ? "" : sell, 
                      :buy => buy.nil? ? "" : buy,
                      :demand => demand.nil? ? 0 : demand,
                      :demandLevel => demandLevel.nil? ? "" : demandLevel,
                      :supply => supply.nil? ? 0 : supply,
                      :supplyLevel => supplyLevel.nil? ? "" : supplyLevel
                    }
  end
  
  def to_json
    return { :system => @system, :station => @station, :commodities => @commodities }.to_json
  end
  
end