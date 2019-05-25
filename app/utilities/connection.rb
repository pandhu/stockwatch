require 'rest-client'

module Connection
  RestDefault = { open_timeout: ENV['DEFAULT_OPEN_TIMEOUT'].to_i, timeout: ENV['DEFAULT_TIMEOUT'].to_i }

  def self.restclient(opts, &block)
    RestClient::Request.execute(RestDefault.merge(opts), &block)
  end

  def self.get(url, header, query={})
    restclient_connection('get', url, header, {}, query)
  end

  def self.post(url, header, payload)
    restclient_connection('post', url, header, payload)
  end

  def self.patch(url, header, payload)
    restclient_connection('patch', url, header, payload)
  end

  def self.restclient_connection(http_method, url, header, payload={}, query={})
    headers = {
      content_type: :json,
      accept: :json
    }
    if !header.nil?
      headers.merge!(header)
    end
    begin
      case http_method.to_sym
      when :get
        headers[:params] = query
        restclient({
          method: http_method.to_sym,
          url: url,
          headers: headers
        })
      when :post, :patch
        restclient({
          method: http_method.to_sym,
          url: url,
          payload: payload.to_json,
          headers: headers,
          timeout: 60
        })
      else
        raise 'unsupported method'
      end
    rescue RestClient::Exception => e
      log_message = {
        http_method: http_method,
        url: url,
        payload: payload,
        query: query,
        response: {
          message: e.message,
          code: e.response&.code,
          body: e.response&.body
        }
      }.to_s
      log_request(['restclient', 'error'], log_message)
      raise
    end
  end

  def self.log_request(tags, message, track_id = nil)
    log = {
      tags: tags,
      message: message
    }
    log[:track_id] = track_id.to_s unless track_id.nil?
  end
end

