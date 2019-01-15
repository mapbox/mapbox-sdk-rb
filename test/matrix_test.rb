require 'mapbox'
require 'test/unit'
require 'mocha/setup'
require 'shoulda'

module Mapbox
  class MatrixTest < Test::Unit::TestCase
    should "#matrix" do
      Mapbox.access_token = ENV["MapboxAccessToken"]
      result = Mapbox::Matrix.matrix([{
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
  end
end
