module ApplicationHelper

  def users_verb(count)
    count == 1 ? "is" : "are"
  end

  require 'net/http'

  def url_exists?(url_string)
    url = URI.parse(url_string)
    req = Net::HTTP.new(url.host, url.port)
    req.use_ssl = (url.scheme == 'https')
    path = url.path if url.path.present?
    res = req.request_head(path || '/')
    res.code.to_i == 200
  end
end
