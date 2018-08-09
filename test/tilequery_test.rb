require 'mapbox'
require 'test/unit'
require 'mocha/setup'
require 'shoulda'

module Mapbox
  class TilequeryTest < Test::Unit::TestCase
    should "#tilequery" do
      Mapbox.access_token = ENV["MapboxAccessToken"]
      result = Mapbox::Tilequery.tilequery(
        "mapbox.mapbox-streets-v7", {"longitude" => -122.42901, "latitude" => 37.80633}, 5, 10)
      assert result
    end
  end
end
