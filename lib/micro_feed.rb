require "net/http"
require "uri"

class MicroFeed
	
	# Wysyła wiadomość do podanych serwisów mikroblogowych
  # Dostępne opcje:
  # * +:streams+: serwisy do których ma dojść wiadomość(:all, [:blip, :flaker], :blip)
  # * +msg+: treść wiadomości
  # * +link+: link do strony
  # * +tags+: tablica z tagami(np. ['sport', 'telewizja'])
  # * +spawn+: standardowo false. Ustawienia na true spowoduje użycie pluginu spawn podczas wysyłania wiadomości
	
	def self.send(config={})
		default = {
			:streams => :all, 
			:msg => "Hello World!", 
			:link => "", 
			:tags => [],
			:spawn => false
		}.merge!(config)
		
		available_streams = MICRO_FEED_CONFIG.map { |stream, config| stream.to_sym }
		
		if default[:streams] == :all
			send_to = available_streams
		elsif streams.class == Symbol
			send_to = available_streams.include?(default[:streams].to_sym) ? [default[:streams]] : available_streams
		else
			send_to = default[:streams].reject { |stream| !available_streams.include?(stream.to_sym) }
		end
		
		send_to.each do |stream_name|
			config = MICRO_FEED_CONFIG[stream_name.to_s]
			sender = eval("#{stream_name.camelize}Feed").new
			sender.setup(config)
			
			if default[:spawn]
				spawn do
					sender.send(default)
				end
			else
				sender.send(default)
			end
		end
	end
end