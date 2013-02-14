require "igolf-client/version"
require "openssl"
require "base64"
require "net/http"

require "igolf-client/configuration"

module IGolf
  class << self
    
    def configure(&block)
      yield(configuration)
      configuration
    end

    def configuration
      @_configuration ||= Configuration.new
    end
    
    def get(action_code, request_payload = {})
      request_time = Time.now
      timestamp = request_time.strftime("%y%m%d%H%M%S%z")
     
      string_to_sign = "#{action_code}/#{configuration.application_api_key}/"
      string_to_sign << "#{configuration.api_key}/" unless configuration.api_key.nil?
      string_to_sign << "#{configuration.api_version}/#{configuration.signature_version}/#{configuration.signature_method}/#{timestamp}/#{configuration.request_format}"


      uri = URI.parse(configuration.api_host)
      http = Net::HTTP.new(uri.host, uri.port)
      #http.use_ssl = true
      #http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      
      request = Net::HTTP::Post.new(generate_signed_url(string_to_sign))
      request.add_field('Content-Type', 'application/json')
      request.body = request_payload
      response = http.request(request)
      response_data = response.body
      
    end
    
    private
    
    def generate_signed_url(string_to_sign)
      digest = OpenSSL::Digest::Digest.new("sha256")
      string_elements = string_to_sign.split("/")
      key = (string_elements.length == 8) ? configuration.application_secret_key + string_elements[3] : configuration.application_secret_key
        
      hmac_string = OpenSSL::HMAC.digest(digest, key, string_to_sign)
      signature = Base64.urlsafe_encode64(hmac_string).gsub!(/=+$/, "")
        
      url = string_elements.insert(-2, signature).join("/")
    end
    
  end
end
