require "igolf-client/version"
require "openssl"
require "base64"
require "net/http"
require "rest_client"
require "active_support/core_ext"

require "igolf-client/configuration"

module IGolf
  class << self
    
    @_configured = false
    
    def configure(&block)
      yield(configuration)
      @_configured = true
      configuration
    end

    def configuration
      @_configuration ||= Configuration.new
    end
    
    def get(action_code, request_payload = {})
      
      raise Exception.new("The iGolf Client must configured before use") unless @_configured
      raise Exception.new("application_api_key required") if configuration.application_api_key.nil?
      raise Exception.new("application_secret_key required") if configuration.application_secret_key.nil?
      
      request_time = Time.now
      timestamp = request_time.strftime("%y%m%d%H%M%S%z")
     
      string_to_sign = "#{action_code}/#{configuration.application_api_key}/"
      string_to_sign << "#{configuration.api_key}/" unless configuration.api_key.nil?
      string_to_sign << "#{configuration.api_version}/#{configuration.signature_version}/#{configuration.signature_method}/#{timestamp}/#{configuration.request_format}"

      RestClient.post configuration.api_host + generate_signed_url(string_to_sign), request_payload.to_json, :content_type => :json, :accept => :json
      
    end
    
    private
    
    def generate_signed_url(string_to_sign)
      digest = OpenSSL::Digest.new("sha256")
      string_elements = string_to_sign.split("/")
      key = (string_elements.length == 8) ? configuration.application_secret_key + string_elements[3] : configuration.application_secret_key
        
      hmac_string = OpenSSL::HMAC.digest(digest, key, string_to_sign)
      signature = Base64.urlsafe_encode64(hmac_string).gsub!(/=+$/, "")
        
      url = string_elements.insert(-3, signature).join("/")
    end
    
  end
end
