require 'rest-client'
require 'json'

module Mapbox
  class Tilequery
    include Mapbox::APIOperations::Request
    extend Mapbox::HashUtils

    def self.tilequery(mapid, location)
      lon = location['longitude'].round(5)
      lat = location['latitude'].round(5)
      return request(
        :get,
        "/v4/#{mapid}/tilequery/#{lat},#{lon}.json",
        nil)
    end
  end
end