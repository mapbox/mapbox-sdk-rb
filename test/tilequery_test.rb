require 'mapbox'
require 'test/unit'
require 'mocha/setup'
require 'shoulda'

module Mapbox
  class TileQueryTest < Test::Unit::TestCase
    should "#tilequery" do
      Mapbox.access_token = ENV["MapboxAccessToken"]
      result = Mapbox::TileQuery.tilequery([
        {
          :longitude => -100,
          :latitude => 38
        },
        {
          :longitude => -90,
          :latitude => 38
        }
      ])
      assert result
    end
  end
end
