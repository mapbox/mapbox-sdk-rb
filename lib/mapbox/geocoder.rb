require 'rest-client'
require 'json'

module Mapbox
  class Geocoder
    include Mapbox::APIOperations::Request
    extend Mapbox::HashUtils

    def self.geocode_forward(query, options={}, dataset='mapbox.places')
      proximity = options[:proximity] || nil
      bbox = options[:bbox] || nil
      params = ''

      if proximity != nil then
        lon = proximity[:longitude].round(3)
        lat = proximity[:latitude].round(3)
        params += "#{params.length > 0 ? '&' : '?'}proximity=#{lon}%2C#{lat}"
      end

      if bbox != nil then
        minX = bbox[0]
        minY = bbox[1]
        maxX = bbox[2]
        maxY = bbox[3]
        params += "#{params.length > 0 ? '&' : '?'}bbox=#{minX}%2C#{minY}%2C#{maxX}%2C#{maxY}"
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
