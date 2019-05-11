require 'rest-client'
require 'json'
require 'uri'

module Mapbox
  class Tokens
    include Mapbox::APIOperations::Request
    extend Mapbox::HashUtils

    def self.assemble_params(options={})
      params = ''
      if options.length > 0
        params += "#{params.length > 0 ? '&' : '?'}#{URI.encode_www_form(options)}"
      end

      return params
    end

    def self.tokens_list(username, options={})
      params = self.assemble_params(options)
      
      return request(
        :get,
        "/tokens/v2/#{URI.escape(username)}#{params}",
        nil)
    end
  end
end