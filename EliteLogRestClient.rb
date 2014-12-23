require 'logging'
require 'rest_client'
class EliteLogRestClient
  
  def initialize(base_url)
    @logger = Logging.logger[self]
    @base_url = base_url
    @logger.info("EliteLogRestClient configured for base_url: #{@base_url}")
  end
  
  
  def log_system_visit(system)
    
    # Construct the body data using Hash => json
    postData = {
      :system => system
    }.to_json
    
    system_visit_url = URI.join(@base_url, "systemVisits").to_s
    
    @logger.debug("Full URL for log_system_visit: #{system_visit_url}")
    @logger.debug("Data being sent as post body: #{postData.to_s}")
    response = RestClient.post system_visit_url, postData.to_s, :content_type => :json
  
    if response.code != 201
      @logger.error("Non Created status return from system_visit_url, code: #{response.code}")
      raise "System visit call did not return Created status"
    end
  end
  
  def update_commodity_prices(marketData)
    
    
    
    post_data = marketData.to_json
    update_commodity_prices_url = URI.join(@base_url, "commodities").to_s
    
    @logger.debug("Full URL for update_commodity_prices: #{update_commodity_prices_url}")
    @logger.debug("Data being sent as post body: #{post_data.to_s}")
    
    response = RestClient.post update_commodity_prices_url, post_data.to_s, :content_type => :json
    
    if response.code != 201
      @logger.error("Non created status return from update_commodity_prices, code: #{response.code}")
      raise "Update commodity prices failed"
    end
  end
  
end