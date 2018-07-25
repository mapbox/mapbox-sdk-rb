module Mapbox
  class Directions
    include Mapbox::APIOperations::Request
    extend Mapbox::HashUtils
    def self.directions(waypoints, profile='driving')
      formatted_waypoints = waypoints.map {|p| xy_from_hash(p).join ','}.join ';'
      return request(
          :get,
          "/directions/v5/mapbox/#{profile}/#{formatted_waypoints}.json",
          nil)
    end
  end
end