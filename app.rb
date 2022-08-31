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
items_alfred = []
rss.items.each do |item|
  title = item.title
  link = item.link
  items << { title: title, link: link }
  items_alfred << {
    title: title,
    subtitle: link,
    arg: link,
  }
end
alfred = { items: items_alfred }

File.write("releases.json", JSON.pretty_generate(items))
File.write("alfred.json", alfred.to_json)
