require 'rest-client'
require 'json'
require 'uri'

module Mapbox
  class Geocoder
    include Mapbox::APIOperations::Request
    extend Mapbox::HashUtils

    def self.assemble_params(options={})
      proximity = options[:proximity]
      bbox = options[:bbox]
      types = options[:types]
      params = ''
      opts = options.select { |key, value| key != :proximity && key != :bbox && key != :types}
      if opts.length > 0
        params += "#{params.length > 0 ? '&' : '?'}#{URI.encode_www_form(opts)}"
      end

      if proximity then
        lon = proximity[:longitude].round(3)
        lat = proximity[:latitude].round(3)
        params += "#{params.length > 0 ? '&' : '?'}proximity=#{lon}%2C#{lat}"
      end

      if bbox then
        params += "#{params.length > 0 ? '&' : '?'}bbox=#{bbox.join('%2C')}"
      end

      if types then
        params += "#{params.length > 0 ? '&' : '?'}types=#{types.join('%2C')}"
      end

      return params
    end

    def self.geocode_forward(query, options={}, dataset='mapbox.places')
      params = self.assemble_params(options)

      return request(
        :get,
        "/geocoding/v5/#{dataset}/#{URI.encode_www_form_component(query)}.json#{params}",
        nil)
    end

    def self.geocode_reverse(location, options={}, dataset='mapbox.places')
      location[:longitude] = location[:longitude].round(5)
      location[:latitude] = location[:latitude].round(5)

      params = self.assemble_params(options)

      return request(
        :get,
        "/geocoding/v5/#{dataset}/#{xy_from_hash(location).join(',')}.json#{params}",
        nil)
    end
  end
end
