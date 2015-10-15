require 'rest-client'
require 'json'

module Mapbox
  class Geocoder
    include Mapbox::APIOperations::Request
    extend Mapbox::HashUtils

    def self.geocode_forward(query, proximity=nil, dataset='mapbox.places')
      proximity_param = ''
      if proximity != nil then
        lon = proximity[:longitude].round(3)
        lat = proximity[:latitude].round(3)
        proximity_param = "?proximity=#{lon}%2C#{lat}"
      end

      return request(
        :get,
        "/geocoding/v5/#{dataset}/#{URI.escape(query)}.json#{proximity_param}",
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
