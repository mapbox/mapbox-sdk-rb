require 'rest-client'
require 'json'

module Mapbox
  class TileQuery
    include Mapbox::APIOperations::Request
    extend Mapbox::HashUtils
    def self.tilequery(mapid = 'mapbox.mapbox-streets-v7', lon='37.80633', lat='-122.42901')
      return request(
        :get,
        "/v4/#{mapid}/tilequery/#{lat},#{lon}.json",
        nil)
    end
  end
end
