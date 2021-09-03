require 'mapbox'
require 'test/unit'
require 'mocha/setup'
require 'shoulda'

module Mapbox
  class GeocodingTest < Test::Unit::TestCase

    def setup
      Mapbox.access_token = ENV["MapboxAccessToken"]
    end

    def teardown
      Mapbox.request_open_timeout = nil
      Mapbox.request_timeout = nil
    end

    should "#geocode_forward" do
      result = Mapbox::Geocoder.geocode_forward("Chester, NJ")
      assert result
    end

    should "set_default_timeouts" do
      result = Mapbox::Geocoder.geocode_forward("Chester, NJ")
      assert Mapbox.request_opts[:timeout] = 80
      assert Mapbox.request_opts[:open_timeout] = 30
    end

    should "#geocode_forward (rounded proximity to 3 decimal places)" do
      result = Mapbox::Geocoder.geocode_forward("Chester, NJ", {:proximity => {:longitude => 0.1234567, :latitude => -10.987654}})
      assert result
      assert Mapbox.request_opts[:url].include? '?proximity=0.123%2C-10.988&'
    end

    should "#geocode_forward (include bbox param)" do
      result = Mapbox::Geocoder.geocode_forward("Washington", {:bbox => [-78.3284,38.6039,-78.0428,38.7841]})
      assert result
      assert Mapbox.request_opts[:url].include? '?bbox=-78.3284%2C38.6039%2C-78.0428%2C38.7841';
    end

    should "#geocode_forward (include extra param)" do
      result = Mapbox::Geocoder.geocode_forward("Washington", {:bbox => [-78.3284,38.6039,-78.0428,38.7841], :foo_key => "foo_val", :bar_key => "bar_val"})
      assert result
      assert Mapbox.request_opts[:url].include? '?foo_key=foo_val&bar_key=bar_val';
    end

    should "#geocode_forward (include country param)" do
      result = Mapbox::Geocoder.geocode_forward("Washington", {:country => "ca"})
      assert result
      assert Mapbox.request_opts[:url].include? '?country=ca';
    end

    should "#geocode_forward (include types param)" do
      result = Mapbox::Geocoder.geocode_forward("Washington", {:types => ['poi.landmark', 'address'], :foo_key => "foo_val", :bar_key => "bar_val"})
      assert result
      assert Mapbox.request_opts[:url].include? '?foo_key=foo_val&bar_key=bar_val&types=poi.landmark%2Caddress';
    end

    should "#geocode_reverse" do
      result = Mapbox::Geocoder.geocode_reverse({
        :latitude => 38,
        :longitude => -100
      })
      assert result
    end

    should "#geocode_reverse (rounded coordinates to 5 decimal places)" do
      result = Mapbox::Geocoder.geocode_reverse({
        :latitude => 1.23456789,
        :longitude => -99.8765432
      })
      for coord in result.first['query'] do
        assert coord.to_s.split('.')[-1].length <= 5
      end
    end

    should "set_custom_timeouts" do
      Mapbox.request_timeout = 10
      Mapbox.request_open_timeout = 5
      result = Mapbox::Geocoder.geocode_forward("Chester, NJ", {:proximity => {:longitude => 0.1234567, :latitude => -10.987654}})
      assert Mapbox.request_opts[:timeout] == 10
      assert Mapbox.request_opts[:open_timeout] == 5
    end
  end
end
