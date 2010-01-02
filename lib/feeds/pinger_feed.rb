class PingerFeed
  def self.post_text(text, tags)
    url = URI.parse("http://a.pinger.pl/auth_add_message.json")
    req = Net::HTTP::Post.new(url.path)
    req.basic_auth 'przekaska', 'pr28k@2k@'
    req.set_form_data({'text'=>text, 'tags'=>tags}, '&')
    res = Net::HTTP.new(url.host, url.port).start {|http| http.request(req) }
  end
end