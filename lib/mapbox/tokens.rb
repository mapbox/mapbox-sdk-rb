require 'rest-client'
require 'json'
require 'uri'

module Mapbox
  class Tokens
    include Mapbox::APIOperations::Request
    extend Mapbox::HashUtils

    def self.assemble_params(options={})
      
    end

    def self.tokens_list(username, options={})
      params = self.assemble_params(options)
      
      return request(
        :get,
        "/tokens/v2/#{URI.escape(username)}",
        nil)
    end
  end
end