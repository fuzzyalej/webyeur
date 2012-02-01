require 'goliath'
require 'yaml'
require 'em-synchrony'
require 'em-synchrony/em-http'
require 'nokogiri'
require 'json'

class Webyeur < Goliath::API
  use Goliath::Rack::Params

  def extract_data_from(doc)
    title = doc.at_css('title').content
    data = {title: title}
    data.to_json
  end

  def response(env)
    #Check url in env.params
    doc = Nokogiri::HTML(EM::HttpRequest.new("http://www.google.com/").get(redirects: 1).response)
    [200, {}, extract_data_from(doc)]
  end
end
