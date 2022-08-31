require "rss"
require "net/http"
require "uri"
require "json"

feed_url = "https://enterprise.github.com/releases.rss"
uri = URI.parse(feed_url)
rss_source = Net::HTTP.get(uri)
begin
  rss = RSS::Parser.parse(rss_source)
rescue RSS::InvalidRSSError
  rss = RSS::Parser.parse(rss_source, false)
end

items = []
rss.items.each do |item|
  title = item.title
  link = item.link
  items << { title: title, link: link }
end

File.write("releases.json", JSON.pretty_generate(items))
