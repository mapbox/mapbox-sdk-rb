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

  class HashUtilTest < Test::Unit::TestCase
    include Mapbox::HashUtils

    should "return array of long,lat from hash with string keys" do
      assert_equal xy_from_hash({'longitude' => -122, 'latitude' => 45}),
                   [-122, 45]
    end

    should "return array of long,lat from hash with symbol keys" do
      assert_equal xy_from_hash({:longitude => -122, :latitude => 45}),
                   [-122, 45]
    end

    should "return array of long,lat from hash with mixed keys" do
      assert_equal xy_from_hash({:longitude => -122, 'latitude' => 45}),
                   [-122, 45]
    end

    should "raise arguemnt error if not given a hash" do
      assert_raise { xy_from_hash(Object.new) }
    end
  end
end
