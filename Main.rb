require 'optparse'
require 'logging'
require 'fileutils'
require_relative 'MarketData'
require_relative 'OCRCSVParser'
require_relative 'EliteLogRestClient'
require_relative 'CommodityLoader'


Logging.logger.root.level = :warn
Logging.logger.root.add_appenders(
  Logging.appenders.stdout
)
logger = Logging.logger["Elite_OCR_CSV_Parser_Main"]
options = { :config => "./config.yml"}
  
optparse = OptionParser.new do |opts|
  opts.on('-c', '--config CONFIG', 'The configuration file for the program, DEFAULT: "./config.yml"') do |c|
    options[:config] = c
  end 
end

Signal.trap("TERM") {
  logger.warn("SIGTERM signal caught...Exiting...")
  exit
}
Signal.trap("INT") {
  logger.warn("INTERRUPT signal caught...Exiting...")
  exit
}

optparse.parse!

config = YAML.load_file(options[:config])
case config["log_level"]
when "ERROR"
  Logging.logger.root.level = :error
when "WARN"
  Logging.logger.root.level = :warn
when "INFO"
  Logging.logger.root.level = :info
when "DEBUG"
  Logging.logger.root.level = :debug
when "OFF"
  Logging.logger.root.level = :off
else 
  Logging.logger.root.level = :warn 
end

logger.info("Config loaded from file #{options[:config]}")
logger.debug("Config: #{config}")

CommodityLoader.loadCommodities(config)



#restClient = EliteLogRestClient.new(config["base_url"])
#restClient.log_system_visit("system_name")

#data = OCRCSVParser.parse_file("C:\\Users\\coder\\Documents\\elite\\ocr_out\\PUDWILL GORIE HUB.csv")
#
##puts data
#
#data.each() do |station, marketData|
#  #puts "Station: #{station} MarketData.commodities #{marketData.commodities}"
#  commods = marketData.to_json.to_s
#  puts commods
#end
#

  
