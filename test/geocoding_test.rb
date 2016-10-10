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
      result = Mapbox::Geocoder.geocode_forward("Chester, NJ", {:proximity => {:longitude => 0.1234567, :latitude => -10.987654}})
      assert result
      assert Mapbox.request_opts[:url].include? '?proximity=0.123%2C-10.988&'
    end

    should "#geocode_forward (include bbox param)" do
      Mapbox.access_token = ENV["MapboxAccessToken"]
      result = Mapbox::Geocoder.geocode_forward("Washington", {:bbox => [-78.3284,38.6039,-78.0428,38.7841]})
      assert result
      assert Mapbox.request_opts[:url].include? '?bbox=-78.3284%2C38.6039%2C-78.0428%2C38.7841';
    end

    should "#geocode_forward (include extra param)" do
      Mapbox.access_token = ENV["MapboxAccessToken"]
      result = Mapbox::Geocoder.geocode_forward("Washington", {:bbox => [-78.3284,38.6039,-78.0428,38.7841], :foo_key => "foo_val", :bar_key => "bar_val"})
      assert result
      assert Mapbox.request_opts[:url].include? '?foo_key=foo_val&bar_key=bar_val';
    end

    should "#geocode_forward (include country param)" do
      Mapbox.access_token = ENV["MapboxAccessToken"]
      result = Mapbox::Geocoder.geocode_forward("Washington", {:country => "ca"})
      assert result
      assert Mapbox.request_opts[:url].include? '?country=ca';
    end

    should "#geocode_forward (include limit param)" do
      Mapbox.access_token = ENV["MapboxAccessToken"]
      result = Mapbox::Geocoder.geocode_forward("Washington", {:limit => 3})
      assert result
      assert Mapbox.request_opts[:url].include? '?limit=3';
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
