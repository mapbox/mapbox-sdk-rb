require 'mapbox'
require 'test/unit'
require 'mocha/setup'
require 'shoulda'

module Mapbox
  class TilequeryTest < Test::Unit::TestCase
    should "#tilequery" do
      Mapbox.access_token = ENV["MapboxAccessToken"]
      result = Mapbox::Tilequery.tilequery(
        "mapbox.mapbox-streets-v7", {"longitude" => -100, "latitude" => 38})
      assert result
    end
  end
end
