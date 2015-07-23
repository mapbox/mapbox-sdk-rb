require 'rest-client'
require 'json'

module Mapbox
  class Directions
    include Mapbox::APIOperations::Request
    def self.directions(waypoints, profile='mapbox.driving')
      formatted_waypoints = waypoints.map { |point|
        "#{point['longitude']},#{point['latitude']}"
      }.join(';')
      return request(
        :get,
        "/v4/directions/#{profile}/#{formatted_waypoints}.json",
        nil)
    end
  end
end
