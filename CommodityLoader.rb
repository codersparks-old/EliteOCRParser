require 'logging'

class CommodityLoader
  
  @logger = Logging.logger[self]
  
  def self.loadCommodities(config)
    csv_dir_glob=config["ocr_out_dir_glob"]
    #csv_glob=File.join(csv_dir, config["ocr_out_glob_pattern"])



    rest_client = EliteLogRestClient.new(config["base_url"])
    loop {
      @logger.debug("Checking for csv files...#{csv_dir_glob}")
      file_list = Dir[csv_dir_glob]

      if file_list.length >= 1
        file_list.each do |file_name|
          @logger.info("Processing File: #{file_name}")
          parsed_market_data = OCRCSVParser.parse_file(file_name)
          parsed_market_data.each do |data|
            @logger.debug("Sending data to rest interface")
            rest_client.update_commodity_prices(data)
          end
          #FileUtils.rm_rf(file_name)
          puts "Breaking...."
          exit()
	
        end
      else
        @logger.info("No files found...")
      end
      @logger.debug("Sleeping for #{config["sleep_time"]} seconds")
      sleep(config["sleep_time"])

    }
  end
end