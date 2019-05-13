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

    def self.token_create(username, note, scopes, allowedUrls=[])
      scopes = scopes || []

      params = {'note' => note, 'scopes' => scopes}
      params.update('allowedUrls' => allowedUrls) if allowedUrls && allowedUrls.any?

      return request(
        :post,
        "/tokens/v2/#{URI.escape(username)}",
        params)
    end
  end
end