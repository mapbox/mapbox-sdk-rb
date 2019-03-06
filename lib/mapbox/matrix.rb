module Mapbox
  class Matrix
    include Mapbox::APIOperations::Request
    extend Mapbox::HashUtils

    def self.assemble_params(options={})
      opts = options.dup

      self.joinArrayParam(opts, :destinations)
      self.joinArrayParam(opts, :annotations, ',')
      self.joinArrayParam(opts, :approaches)
      self.joinArrayParam(opts, :sources)

      return "?#{URI.encode_www_form(opts)}"
    end

    def self.joinArrayParam(opts, name, joinSymbol = ';')
      if opts[name].kind_of?(Array)
        opts[name] = opts[name].join(joinSymbol)
      end
    end

    def self.matrix(waypoints, profile, options={})
      formatted_waypoints = waypoints.map {|p| xy_from_hash(p).join ','}.join ';'
      params = self.assemble_params(options)
      return request(
          :get,
          "/directions-matrix/v1/mapbox/#{profile}/#{formatted_waypoints}.json#{params}",
          nil)
    end
  end
end