module Mapbox
  class Tilequery
    include Mapbox::APIOperations::Request
    extend Mapbox::HashUtils

    def self.tilequery(mapid, location, radius, limit)
      lon = location['longitude'].round(5)
      lat = location['latitude'].round(5)
      return request(
        :get,
        "/v4/#{mapid}/tilequery/#{lon},#{lat}.json?radius=#{radius}&limit=#{limit}",
        nil)
    end
  end
end