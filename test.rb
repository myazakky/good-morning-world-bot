require "uri"
require 'net/https'
require 'json'


def test_link_parse_hosting
  link = "https://en.wikipedia.org/wiki/"
  uri = URI.parse(link)
  assert_equal "en.wikipedia.org", uri.host
end

def test_api_response
  query = "https://en.wikipedia.org/w/api.php?format=json&action=query&prop=extracts&exintro&explaintext&titles=Tokyo"
  uri = URI.parse(query)
  json = Net::HTTP.get(uri)
  assert JSON.parse(json)['query']['pages'].to_a.flatten.last
end
