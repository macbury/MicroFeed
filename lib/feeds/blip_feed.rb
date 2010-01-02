class BlipFeed < ActiveResource::Base
  self.site = 'http://api.blip.pl'
  self.element_name = "update"
  self.headers['X-Blip-API'] = '0.02'
  self.headers['Accept'] = 'application/json'
  self.headers['User-Agent'] = 'http://github.com/macbury/MicroFeed'
  self.format = :json

	def setup(config={})
		self.user = config['login']
		self.password = config['password']
	end
	
	def send(options={})
		body = options[:msg]
		body += " - " + options[:link] if options[:link]
		body += " " + tags.map { |tag| "##{tag}" }.join(', ') if options[:tags] 
		Blip.create :body => body
	end
end