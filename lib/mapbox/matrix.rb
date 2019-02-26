module Mapbox
  class Matrix
    include Mapbox::APIOperations::Request
    extend Mapbox::HashUtils

    def self.assemble_params(opts={})
      self.joinArrayParam(opts, :destinations)
      self.joinArrayParam(opts, :annotations)
      self.joinArrayParam(opts, :approaches)
      self.joinArrayParam(opts, :sources)

      return "?#{URI.encode_www_form(opts)}"
    end

    def self.joinArrayParam(opts, name)
      if opts[name].kind_of?(Array)
        # The annotations parameter requires a comma separated list
        if name == :annotations
          opts[name] = opts[name].join(',')
        # Other parameters must be be semi-colon separated
        else
          opts[name] = opts[name].join(';')
        end
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