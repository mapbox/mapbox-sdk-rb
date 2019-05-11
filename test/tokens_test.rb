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

    should "#tokens_list (include true default param)" do
      Mapbox.access_token = ENV["MapboxAccessToken"]
      result = Mapbox::Tokens.tokens_list(ENV["MapboxUsername"], {:default => true})
      assert result
      assert Mapbox.request_opts[:url].include? '?default=true'
    end

    should "#tokens_list (include false default param)" do
      Mapbox.access_token = ENV["MapboxAccessToken"]
      result = Mapbox::Tokens.tokens_list(ENV["MapboxUsername"], {:default => false})
      assert result
      assert Mapbox.request_opts[:url].include? '?default=false'
    end

    should "#tokens_list (include public key usage param)" do
      Mapbox.access_token = ENV["MapboxAccessToken"]
      result = Mapbox::Tokens.tokens_list(ENV["MapboxUsername"], {:usage => "pk"})
      assert result
      assert Mapbox.request_opts[:url].include? '?usage=pk'
    end

    should "#tokens_list (include private key usage param)" do
      Mapbox.access_token = ENV["MapboxAccessToken"]
      result = Mapbox::Tokens.tokens_list(ENV["MapboxUsername"], {:usage => "sk"})
      assert result
      assert Mapbox.request_opts[:url].include? '?usage=sk'
    end

  end
end