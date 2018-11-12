require 'mapbox'
require 'test/unit'
require 'mocha/setup'
require 'shoulda'

module Mapbox
  class IsochroneTest < Test::Unit::TestCase
    should "#isochrone" do
      Mapbox.access_token = ENV["MapboxAccessToken"]
      puts "access token is #{ENV["MapboxAccessToken"]}"
      result = Mapbox::Isochrone.isochrone(
        "walking", "-118.22258,33.99038", {contours_minutes: [5,10,15]})
      assert result
    end
  end
end