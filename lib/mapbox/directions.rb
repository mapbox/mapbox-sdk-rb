require 'rest-client'
require 'json'

module Mapbox
  class Directions
    include Mapbox::APIOperations::Request
    extend Mapbox::HashUtils
    def self.directions(waypoints, profile='mapbox.driving')
      formatted_waypoints = waypoints.map {|p| xy_from_hash(p).join ','}.join ';'
      return request(
        :get,
        "/v4/directions/#{profile}/#{formatted_waypoints}.json",
        nil)
    end
  end
end
