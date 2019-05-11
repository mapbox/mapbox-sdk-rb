require 'mapbox'
require 'test/unit'
require 'mocha/setup'
require 'shoulda'

module Mapbox
  class TokensTest < Test::Unit::TestCase
    should "#tokens_list" do
      Mapbox.access_token = ENV["MapboxAccessToken"]
      result = Mapbox::Tokens.tokens_list(ENV["MapboxUsername"])
      assert result
    end

  end
end