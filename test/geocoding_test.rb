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

    should "#geocode_forward (rounded proximity to 3 decimal places)" do
      Mapbox.access_token = ENV["MapboxAccessToken"]
      result = Mapbox::Geocoder.geocode_forward("Chester, NJ", proximity={:longitude => 0.1234567, :latitude => -10.987654})
      assert result
      assert Mapbox.request_opts[:url].include? '?proximity=0.123%2C-10.988&'
    end

    should "#geocode_reverse" do
      Mapbox.access_token = ENV["MapboxAccessToken"]
      result = Mapbox::Geocoder.geocode_reverse({
        :latitude => 38,
        :longitude => -100
      })
      assert result
    end

    should "#geocode_reverse (rounded coordinates to 5 decimal places)" do
      Mapbox.access_token = ENV["MapboxAccessToken"]
      result = Mapbox::Geocoder.geocode_reverse({
        :latitude => 1.23456789,
        :longitude => -99.8765432
      })
      for coord in result.first['query'] do
        assert coord.to_s.split('.')[-1].length <= 5
      end
    end

  end
end
