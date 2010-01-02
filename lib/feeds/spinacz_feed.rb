class SpinaczFeed
  def self.post_text(text)
    url = URI.parse("http://spinacz.pl/feeds/add.json")
    req = Net::HTTP::Post.new(url.path)
    req.set_form_data({'content'=> text, 'HASH'=> '839c82e0679b64132f528fa71a9e88d1'}, '&')
    res = Net::HTTP.new(url.host, url.port).start {|http| http.request(req) }
  end
end