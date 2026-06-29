require 'rest-client'
require 'json'
require 'mapbox/api_operations'
require 'mapbox/authentication_error'

module Mapbox
  @api_base = 'https://api.mapbox.com'
  @request_opts = {}

  LATITUDE_KEY = 'latitude'.freeze
  LONGITUDE_KEY = 'longitude'.freeze

  class << self
    attr_accessor :access_token, :api_base, :request_opts, :request_timeout, :request_open_timeout
  end

  def self.request(method, url, api_key, params={}, headers={}, api_base_url=nil)
    api_base_url = api_base_url || @api_base
    params = params || {}

    unless access_token ||= @access_token
      raise AuthenticationError.new('No API key provided. ' \
        'Set your API key using "Mapbox.access_token = <access_token>". ' \
        'You can generate API keys from the Mapbox web interface. ' \
        'See https://mapbox.com/developers for details, or email help@mapbox.com ' \
        'if you have any questions.')
    end

    url = api_base_url + url

    params['access_token'] = access_token

    case method.to_s.downcase.to_sym
    when :get, :head, :delete
      # Make params into GET parameters
      url += "#{URI.parse(url).query ? '&' : '?'}#{URI.encode_www_form(params)}" if params && params.any?
      payload = nil
    end

    @request_opts = {:verify_ssl => OpenSSL::SSL::VERIFY_PEER,
                      :ssl_ca_file => @ssl_bundle_path}

    @request_opts.update(
      :method => method,
      :open_timeout => @request_open_timeout || 30,
      :payload => payload,
      :url => url,
      :timeout => @request_timeout || 80)

    begin
      response = execute_request(@request_opts)
    rescue SocketError => e
      handle_restclient_error(e, api_base_url)
    rescue NoMethodError => e
      # Work around RestClient bug
      if e.message =~ /\WRequestFailed\W/
        e = StandardError.new('Unexpected HTTP response code')
        handle_restclient_error(e, api_base_url)
      else
        raise
      end
    rescue RestClient::ExceptionWithResponse => e
      if e.response
        handle_api_error(e, e.response)
      else
        handle_restclient_error(e, api_base_url)
      end
    rescue RestClient::Exception, Errno::ECONNREFUSED => e
      handle_restclient_error(e, api_base_url)
    end

    [parse(response), api_key]
  end

  def self.uri_encode(params)
    params.
      map { |k,v| "#{k}=#{url_encode(v)}" }.join('&')
  end

  def self.url_encode(key)
    URI.encode_www_form_component(key.to_s)
  end

  def self.execute_request(opts)
    RestClient::Request.execute(opts)
  end

  def self.parse(response)
    begin
      # Would use :symbolize_names => true, but apparently there is
      # some library out there that makes symbolize_names not work.
      response = JSON.parse(response.body)
    rescue JSON::ParserError
      raise general_api_error(response.code, response.body)
    end

    response
  end

  def self.general_api_error(rcode, rbody)
    StandardError.new("Invalid response object from API: #{rbody.inspect} " +
                 "(HTTP response code was #{rcode})")
  end

  def self.handle_api_error(rcode, rbody)
    begin
      error = JSON.parse(rbody)
      raise StandardError.new unless error.has_key?("message") # escape from parsing

    rescue JSON::ParserError, StandardError
      raise general_api_error(rcode, rbody)
    end

    case rcode
    when 400, 404
      raise invalid_request_error error, rcode
    when 401
      raise authentication_error error, rcode
    else
      raise api_error error, rcode
    end

  end

  def self.invalid_request_error(error, rcode)
    StandardError.new("Request Error: #{rcode} - #{error["message"]}")
  end

  def self.authentication_error(error, rcode)
    AuthenticationError.new("Authentication Error: #{rcode} - #{error["message"]}")
  end

  def self.api_error(error, rcode)
    StandardError.new("API Error: #{rcode} - #{error["message"]}")
  end

  def self.handle_restclient_error(e, api_base_url=nil)
    api_base_url = @api_base unless api_base_url
    connection_message = "Please check your internet connection and try again. " \
        "If this problem persists, you should check Mapbox's service status at " \
        "https://status.mapbox.com/, or let us know at help@mapbox.com."

    case e
    when RestClient::RequestTimeout
      message = "Could not connect to Mapbox (#{api_base_url}). #{connection_message}"

    when RestClient::ServerBrokeConnection
      message = "The connection to the server (#{api_base_url}) broke before the " \
        "request completed. #{connection_message}"

    when RestClient::SSLCertificateNotVerified
      message = "Could not verify Mapbox's SSL certificate. " \
        "Please make sure that your network is not intercepting certificates. " \
        "(Try going to https://api.mapbox.com/ in your browser.) " \
        "If this problem persists, let us know at help@mapbox.com."

    when SocketError
      message = "Unexpected error communicating when trying to connect to Mapbox. " \
        "You may be seeing this message because your DNS is not working. " \
        "To check, try running 'host mapbox.com' from the command line."

    else
      message = "Unexpected error communicating with Mapbox. " \
        "If this problem persists, let us know at help@mapbox.com."

    end

    raise StandardError.new(message + "\n\n(Network error: #{e.message})")
  end

  module HashUtils
    def xy_from_hash h = {}
      [ h.fetch(:longitude){ h[LONGITUDE_KEY] },
        h.fetch(:latitude){ h[LATITUDE_KEY] } ]
    end
  end
end

# services
require 'mapbox/geocoder'
require 'mapbox/directions'
require 'mapbox/tilequery'
require 'mapbox/isochrone'
require 'mapbox/matrix'
require 'mapbox/map_matching'
require 'mapbox/optimization'
