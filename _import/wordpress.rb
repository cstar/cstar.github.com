#!/usr/bin/ruby
require 'rubygems'
require "nokogiri"
require 'net/http'

f = File.open(Dir.glob("wordpress.*.xml").first)
doc = Nokogiri::XML(f)
doc.xpath("/rss/channel/item").each do |entry|
  #puts "#{entry.xpath("wp:post_type/text()")}"
  if entry.xpath("wp:post_type/text()").to_s ==  "attachment"
    url = URI.parse( entry.xpath("wp:attachment_url/text()").to_s)
    req = Net::HTTP::Get.new(url.path)
    res = Net::HTTP.start(url.host, url.port) {|http|
      http.request(req)
    }
    open("../images/#{url.path.split("/").last}", "w") { |file|
      file.write(res.body)
   }
  end
end