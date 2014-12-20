require 'csv'
require 'logging'
class OCRCSVParser
  
  @logger = Logging.logger[self]
  
  def self.parse_file(filename)
    results = {}
    CSV.foreach(filename, {:headers => true, :col_sep => ";"}) do |csv|
      #@logger.debug("CSV: #{csv}")
      station = csv["station"]
      marketData = results[station]
        
      if marketData.nil?
        @logger.info("Station '#{station}' not found in result map...adding")
        system = csv["system"]
        if system.nil? || system == ""
          system = "unknown"
        end
        marketData = MarketData.new(system,csv["station"])
      end
      
      marketData.add_commodity(
            csv["commodity"],
            csv["sell"],
            csv["buy"],
            csv["demand"],
            csv["demand_level"],
            csv["supply"],
            csv["supply_level"])
              
      results[station] = marketData;
    end
    
    return results;
  end
  
  
end