require 'mapbox'
require 'test/unit'
require 'mocha/setup'
require 'shoulda'

module Mapbox
  class MatrixTest < Test::Unit::TestCase
    should "#optimization with just coordinates and profile" do
      Mapbox.access_token = ENV["MapboxAccessToken"]
      result = Mapbox::Optimization.optimization([{
        "longitude" => -122.42,
        "latitude" => 37.78
      }, {
        "longitude" => -122.45,
        "latitude" => 37.91
      }, {
       "longitude" => -122.48,
        "latitude" => 37.73
        }], "walking")
      assert result
    end
    should "#optimization with optional params" do
      Mapbox.access_token = ENV["MapboxAccessToken"]
      result = Mapbox::Optimization.optimization([{
        "longitude" => -122.42,
        "latitude" => 37.78
      }, {
        "longitude" => -122.45,
        "latitude" => 37.91
      }, {
       "longitude" => -122.48,
        "latitude" => 37.73
        }], "cycling", {
          annotations: ["duration", "distance"],
          approaches: ["curb","curb","curb"]
        })
      assert result
    end
    should "#optimization with an empty bearing" do
      Mapbox.access_token = ENV["MapboxAccessToken"]
      result = Mapbox::Optimization.optimization([{
        "longitude" => -122.42,
        "latitude" => 37.78
      }, {
        "longitude" => -122.45,
        "latitude" => 37.91
      }, {
       "longitude" => -122.48,
        "latitude" => 37.73
        }], "driving", {
          bearings: "45,90;;90,1"
        })
      assert result
    end
  end
end
