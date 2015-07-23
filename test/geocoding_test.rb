require 'mapbox'
require 'test/unit'
require 'mocha/setup'
require 'shoulda'

module Mapbox
  class GeocodingTest < Test::Unit::TestCase
    should "#geocode_forward" do
      Mapbox.access_token = ENV["MapboxAccessToken"]
      result = Mapbox::Geocoder.geocode_forward("Chester, NJ")
      assert result
    end

  should "#geocode_reverse" do
      Mapbox.access_token = ENV["MapboxAccessToken"]
      result = Mapbox::Geocoder.geocode_reverse({
        "latitude" => 38,
        "longitude" => -100
      })
      assert result
    end
  end
end
