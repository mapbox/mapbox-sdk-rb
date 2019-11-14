require 'mapbox'
require 'test/unit'
require 'mocha/setup'
require 'shoulda'

module Mapbox
  class TokensTest < Test::Unit::TestCase
    should "#tokens_list" do
      Mapbox.access_token = ENV["MapboxAccessToken"]
      result = Mapbox::Tokens.list_tokens(ENV["MapboxUsername"])
      assert result
    end

    should "#tokens_list (include true default param)" do
      Mapbox.access_token = ENV["MapboxAccessToken"]
      result = Mapbox::Tokens.list_tokens(ENV["MapboxUsername"], {:default => true})
      assert result
      assert Mapbox.request_opts[:url].include? '?default=true'
    end

    should "#tokens_list (include false default param)" do
      Mapbox.access_token = ENV["MapboxAccessToken"]
      result = Mapbox::Tokens.list_tokens(ENV["MapboxUsername"], {:default => false})
      assert result
      assert Mapbox.request_opts[:url].include? '?default=false'
    end

    should "#tokens_list (include public key usage param)" do
      Mapbox.access_token = ENV["MapboxAccessToken"]
      result = Mapbox::Tokens.list_tokens(ENV["MapboxUsername"], {:usage => "pk"})
      assert result
      assert Mapbox.request_opts[:url].include? '?usage=pk'
    end

    should "#tokens_list (include private key usage param)" do
      Mapbox.access_token = ENV["MapboxAccessToken"]
      result = Mapbox::Tokens.list_tokens(ENV["MapboxUsername"], {:usage => "sk"})
      assert result
      assert Mapbox.request_opts[:url].include? '?usage=sk'
    end

    should "#token_get" do
      Mapbox.access_token = ENV["MapboxAccessToken"]
      result = Mapbox::Tokens.get_token
      assert result
    end

    should "#token_create" do
      Mapbox.access_token = ENV["MapboxAccessToken"]
      result = Mapbox::Tokens.create_token(ENV["MapboxUsername"], "mapbox-sdk-rb test", [])
      assert result
      Mapbox::Tokens.delete_token(ENV["MapboxUsername"], result.first["id"]) if result
    end

    should "#token_create (include note param)" do
      Mapbox.access_token = ENV["MapboxAccessToken"]
      result = Mapbox::Tokens.create_token(ENV["MapboxUsername"], "mapbox-sdk-rb test", [])
      assert result
      assert Mapbox.request_opts[:payload].include? '"note":"mapbox-sdk-rb test"'
      Mapbox::Tokens.delete_token(ENV["MapboxUsername"], result.first["id"]) if result
    end

    should "#token_create (include scopes param)" do
      Mapbox.access_token = ENV["MapboxAccessToken"]
      result = Mapbox::Tokens.create_token(ENV["MapboxUsername"], "mapbox-sdk-rb test", ["tokens:read"])
      assert result
      assert Mapbox.request_opts[:payload].include? '"scopes":["tokens:read"'
      Mapbox::Tokens.delete_token(ENV["MapboxUsername"], result.first["id"]) if result
    end

    should "#token_create (include allowed URLs param)" do
      Mapbox.access_token = ENV["MapboxAccessToken"]
      result = Mapbox::Tokens.create_token(ENV["MapboxUsername"], "mapbox-sdk-rb test", [], ["example.com"])
      assert result
      assert Mapbox.request_opts[:payload].include? '"allowedUrls":["example.com"'
      Mapbox::Tokens.delete_token(ENV["MapboxUsername"], result.first["id"]) if result
    end

    should "#token_delete" do
      Mapbox.access_token = ENV["MapboxAccessToken"]
      new_token = Mapbox::Tokens.create_token(ENV["MapboxUsername"], "mapbox-sdk-rb test", [])
      result = Mapbox::Tokens.delete_token(ENV["MapboxUsername"], new_token.first["id"])
      assert result
    end

    should "#token_update" do
      Mapbox.access_token = ENV["MapboxAccessToken"]
      new_token = Mapbox::Tokens.create_token(ENV["MapboxUsername"], "mapbox-sdk-rb test", [])
      result = Mapbox::Tokens.update_token(ENV["MapboxUsername"], new_token.first["id"],"mapbox-sdk-rb test (updated)",[])
      assert result
      Mapbox::Tokens.delete_token(ENV["MapboxUsername"], result.first["id"]) if result
    end

    should "#token_update (include scopes param)" do
      Mapbox.access_token = ENV["MapboxAccessToken"]
      new_token = Mapbox::Tokens.create_token(ENV["MapboxUsername"], "mapbox-sdk-rb test", ["tokens:read"])
      result = Mapbox::Tokens.update_token(ENV["MapboxUsername"], new_token.first["id"],"mapbox-sdk-rb test (updated)",["tokens:write"])
      assert result
      assert Mapbox.request_opts[:payload].include? '"scopes":["tokens:write"'
      Mapbox::Tokens.delete_token(ENV["MapboxUsername"], result.first["id"]) if result
    end

    should "#token_update (include allowed URLs param)" do
      Mapbox.access_token = ENV["MapboxAccessToken"]
      new_token = Mapbox::Tokens.create_token(ENV["MapboxUsername"], "mapbox-sdk-rb test", [])
      result = Mapbox::Tokens.update_token(ENV["MapboxUsername"], new_token.first["id"],"mapbox-sdk-rb test (updated)",[], ["example.com"])
      assert result
      assert Mapbox.request_opts[:payload].include? '"allowedUrls":["example.com"'
      Mapbox::Tokens.delete_token(ENV["MapboxUsername"], result.first["id"]) if result
    end

    should "#scopes_list" do
      Mapbox.access_token = ENV["MapboxAccessToken"]
      result = Mapbox::Tokens.list_scopes(ENV["MapboxUsername"])
      assert result
    end
  end
end