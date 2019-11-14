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

    def self.list_tokens(username, options={})
      params = self.assemble_params(options)
      
      return request(
        :get,
        "/tokens/v2/#{URI.escape(username)}#{params}",
        nil)
    end

    def self.get_token()
      return request(
        :get,
        "/tokens/v2/",
        nil)
    end

    def self.create_token(username, note, scopes, allowedUrls=[])
      scopes = scopes || []

      params = {'note' => note, 'scopes' => scopes}
      params.update('allowedUrls' => allowedUrls) if allowedUrls && allowedUrls.any?

      return request(
        :post,
        "/tokens/v2/#{URI.escape(username)}",
        params)
    end

    def self.delete_token(username, token_id)
      return request(
        :delete,
        "/tokens/v2/#{URI.escape(username)}/#{URI.escape(token_id)}")
    end

    def self.update_token(username, token_id, note, scopes, allowedUrls=[])
      scopes = scopes || []

      params = {'note' => note, 'scopes' => scopes}
      params.update('allowedUrls' => allowedUrls) if allowedUrls && allowedUrls.any?

      return request(
        :patch,
        "/tokens/v2/#{URI.escape(username)}/#{URI.escape(token_id)}",
        params)
    end

    def self.list_scopes(username)
      return request(
        :get,
        "/scopes/v1/#{URI.escape(username)}",
        nil)
    end
  end
end