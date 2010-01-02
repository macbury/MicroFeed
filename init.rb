# Include hook code here
require File.join(File.dirname(__FILE__), "lib", "feeds")

MICRO_FEED_CONFIG = YAML.load_file("#{RAILS_ROOT}/config/micro_feed.yml")
