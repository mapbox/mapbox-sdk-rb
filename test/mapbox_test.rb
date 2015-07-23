require 'mapbox'
require 'test/unit'
require 'mocha/setup'
require 'shoulda'

module Mapbox
  class ModuleTest < Test::Unit::TestCase
    should "throw if access_token is not defined" do
      assert_raise {
        Mapbox.request()
      }
    end

    should "allow access token to be set" do
      Mapbox.access_token = "foo"
    end
  end
end
