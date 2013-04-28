module IGolf
  class Configuration
    
    attr_accessor :application_api_key
    attr_accessor :api_key
    attr_accessor :application_secret_key
    attr_accessor :api_host
    attr_accessor :api_version
    attr_accessor :signature_method
    attr_accessor :signature_version
    attr_accessor :request_format
    
    def initialize
      @application_api_key = nil
      @api_key = nil
      @application_secret_key = nil
      @api_host = "https://api-connect.igolf.com/rest/action/"
      @api_version = "1.0"
      @signature_method = "HmacSHA256"
      @signature_version = "2.0"
      @request_format = "JSON"
    end
    
  end
end
