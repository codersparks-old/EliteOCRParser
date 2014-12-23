require 'csv'
require 'logging'
class OCRCSVParser
  
  @logger = Logging.logger[self]
  
  def self.parse_file(filename)
    results = []
    CSV.foreach(filename, {:headers => true, :col_sep => ";"}) do |csv|
      data = {}
      csv.each do | k, v|
      	if k.nil?
      	  @logger.debug("Nil key found value: #{v}, ignoring...")
      	  next
      	end
      	
      	# Transform some of the keys to the relevant name in the webapp
      	case k
      	  when "commodity"
      	    k = "name"
      	  when "demand_level"
      	    k = "demandLevel"
      	    if v.nil?
      	    	v = ""
      	    end
      	  when "supply_level"
      	    k = "supplyLevel"
      	    if v.nil?
      	        v = ""
      	    end
      	end
      	puts "Key #{k.to_sym} Value #{v}"
      	data[k.to_sym] = v
      end
      
      @logger.debug("Data: #{data}")
      
      results << data
    end
    
    @logger.debug("results: #{results}")
    return results;
  end
  
  
end