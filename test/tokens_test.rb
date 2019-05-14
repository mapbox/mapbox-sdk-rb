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

    should "#token_create" do
      Mapbox.access_token = ENV["MapboxAccessToken"]
      result = Mapbox::Tokens.token_create(ENV["MapboxUsername"], "mapbox-sdk-rb test", [])
      assert result
      Mapbox::Tokens.token_delete(ENV["MapboxUsername"], result.first["id"]) if result
    end

    should "#token_create (include note param)" do
      Mapbox.access_token = ENV["MapboxAccessToken"]
      result = Mapbox::Tokens.token_create(ENV["MapboxUsername"], "mapbox-sdk-rb test", [])
      assert result
      assert Mapbox.request_opts[:payload].include? '"note":"mapbox-sdk-rb test"'
      Mapbox::Tokens.token_delete(ENV["MapboxUsername"], result.first["id"]) if result
    end

    should "#token_create (include scopes param)" do
      Mapbox.access_token = ENV["MapboxAccessToken"]
      result = Mapbox::Tokens.token_create(ENV["MapboxUsername"], "mapbox-sdk-rb test", ["tokens:read"])
      assert result
      assert Mapbox.request_opts[:payload].include? '"scopes":["tokens:read"'
      Mapbox::Tokens.token_delete(ENV["MapboxUsername"], result.first["id"]) if result
    end

    should "#token_create (include allowed URLs param)" do
      Mapbox.access_token = ENV["MapboxAccessToken"]
      result = Mapbox::Tokens.token_create(ENV["MapboxUsername"], "mapbox-sdk-rb test", [], ["example.com"])
      assert result
      assert Mapbox.request_opts[:payload].include? '"allowedUrls":["example.com"'
      Mapbox::Tokens.token_delete(ENV["MapboxUsername"], result.first["id"]) if result
    end

    should "#token_delete" do
      Mapbox.access_token = ENV["MapboxAccessToken"]
      new_token = Mapbox::Tokens.token_create(ENV["MapboxUsername"], "mapbox-sdk-rb test", [])
      result = Mapbox::Tokens.token_delete(ENV["MapboxUsername"], new_token.first["id"])
      assert result
    end

    should "#token_update" do
      Mapbox.access_token = ENV["MapboxAccessToken"]
      new_token = Mapbox::Tokens.token_create(ENV["MapboxUsername"], "mapbox-sdk-rb test", [])
      result = Mapbox::Tokens.token_update(ENV["MapboxUsername"], new_token.first["id"],"mapbox-sdk-rb test (updated)",[])
      assert result
      Mapbox::Tokens.token_delete(ENV["MapboxUsername"], result.first["id"]) if result
    end

    should "#token_update (include scopes param)" do
      Mapbox.access_token = ENV["MapboxAccessToken"]
      new_token = Mapbox::Tokens.token_create(ENV["MapboxUsername"], "mapbox-sdk-rb test", ["tokens:read"])
      result = Mapbox::Tokens.token_update(ENV["MapboxUsername"], new_token.first["id"],"mapbox-sdk-rb test (updated)",["tokens:write"])
      assert result
      assert Mapbox.request_opts[:payload].include? '"scopes":["tokens:write"'
      Mapbox::Tokens.token_delete(ENV["MapboxUsername"], result.first["id"]) if result
    end

    should "#token_update (include allowed URLs param)" do
      Mapbox.access_token = ENV["MapboxAccessToken"]
      new_token = Mapbox::Tokens.token_create(ENV["MapboxUsername"], "mapbox-sdk-rb test", [])
      result = Mapbox::Tokens.token_update(ENV["MapboxUsername"], new_token.first["id"],"mapbox-sdk-rb test (updated)",[], ["example.com"])
      assert result
      assert Mapbox.request_opts[:payload].include? '"allowedUrls":["example.com"'
      Mapbox::Tokens.token_delete(ENV["MapboxUsername"], result.first["id"]) if result
    end
  end
end