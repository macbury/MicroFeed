class FlakerFeed
	attr_accessor :login, :password

	def setup(config={})
		self.user = config['login']
		self.password = config['password']
	end
	
	def send(options={})
		url = URI.parse("http://api.flaker.pl/api/type:submit")
		req = Net::HTTP::Post.new(url.path)
		
		req.basic_auth self.user, self.password
		
		body = options[:msg]
		body += " " + tags.map { |tag| "##{tag}" }.join(', ') if options[:tags]
		
		req.set_form_data({'text'=>body, 'link'=>options[:link]}, '&')
		res = Net::HTTP.new(url.host, url.port).start {|http| http.request(req) }
	end
end