require 'rest-client'
require 'json'

module Mapbox
  class Geocoder
    include Mapbox::APIOperations::Request
    extend Mapbox::HashUtils

    def self.geocode_forward(query, proximity=nil, dataset='mapbox.places')
      return request(
        :get,
        "/geocoding/v5/#{dataset}/#{URI.escape(query)}.json",
        nil)
    end

    def self.geocode_reverse(location, dataset='mapbox.places')
      return request(
        :get,
        "/geocoding/v5/#{dataset}/#{xy_from_hash(location).join(',')}.json",
        nil)
    end
  end
end
