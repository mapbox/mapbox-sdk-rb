require 'mapbox'
require 'test/unit'
require 'mocha/setup'
require 'shoulda'

module Mapbox
  class MapMatchingTest < Test::Unit::TestCase
    should "#map match with just coordinates and profile" do
      Mapbox.access_token = ENV["MapboxAccessToken"]
      result = Mapbox::MapMatching.map_matching([{
        "longitude" => -117.17282,
        "latitude" => 32.71204
      }, {
        "longitude" => -117.17288,
        "latitude" => 32.71225
      }, {
        "longitude" => -117.17293,
        "latitude" => 32.71244
        },{
        "longitude" => -117.17292,
        "latitude" => 32.71256
        }], "driving")
      assert result
    end
    should "#map match with optional params" do
      Mapbox.access_token = ENV["MapboxAccessToken"]
      result = Mapbox::MapMatching.map_matching([{
        "longitude" => -117.17282,
        "latitude" => 32.71204
      }, {
        "longitude" => -117.17288,
        "latitude" => 32.71225
      }, {
       "longitude" => -117.17293,
        "latitude" => 32.71244
      }, {
       "longitude" => -117.17292,
        "latitude" => 32.71256
        }], "driving", {
          annotations: ["duration", "distance", "speed"],
          approaches: ["curb","curb","curb","curb"]
        })
      assert result
    end
  end
end
