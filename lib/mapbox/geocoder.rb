require 'rest-client'
require 'json'

module Mapbox
  class Geocoder
    include Mapbox::APIOperations::Request
    extend Mapbox::HashUtils

    def self.geocode_forward(query, options={}, dataset='mapbox.places')
      proximity = options[:proximity]
      bbox = options[:bbox]
      params = ''

      if proximity then
        lon = proximity[:longitude].round(3)
        lat = proximity[:latitude].round(3)
        params += "#{params.length > 0 ? '&' : '?'}proximity=#{lon}%2C#{lat}"
      end

      if bbox then
        params += "#{params.length > 0 ? '&' : '?'}bbox=#{bbox.join('%2C')}"
      end
      return request(
        :get,
        "/geocoding/v5/#{dataset}/#{URI.escape(query)}.json#{params}",
        nil)
    end

    def self.geocode_reverse(location, dataset='mapbox.places')
      location[:longitude] = location[:longitude].round(5)
      location[:latitude] = location[:latitude].round(5)

      return request(
        :get,
        "/geocoding/v5/#{dataset}/#{xy_from_hash(location).join(',')}.json",
        nil)
    end
  end
end
