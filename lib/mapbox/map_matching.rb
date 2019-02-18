module Mapbox
  class MapMatching
    include Mapbox::APIOperations::Request
    extend Mapbox::HashUtils

    def self.assemble_params(options={})
      annotations = options[:annotations]
      approaches = options[:approaches]
      radiuses = options[:radiuses]
      timestamps = options[:timestamps]
      waypoint_names = options[:waypoint_names]
      waypoints = options[:waypoints]
      
      params = ''
      opts = options.select { |key, value| key != :annotations && key != :approaches && key != :radiuses && key != :timestamps && key != :waypoint_names && key != :waypoints  }
      if opts.length > 0
        params += "#{params.length > 0 ? '&' : '?'}#{URI.encode_www_form(opts)}"
      end

      if annotations  then
        params += "#{params.length > 0 ? '&' : '?'}annotations=#{annotations.join(',')}"
      end

      if approaches  then
        params += "#{params.length > 0 ? '&' : '?'}approaches=#{approaches.join(';')}"
      end

      if radiuses then
        params += "#{params.length > 0 ? '&' : '?'}radiuses=#{radiuses.join ';'}"
      end

      if timestamps then
        params += "#{params.length > 0 ? '&' : '?'}timestamps=#{timestamps.join ';'}"
      end

      if waypoint_names then
        params += "#{params.length > 0 ? '&' : '?'}waypoint_names=#{waypoint_names.join ';'}"
      end

      if waypoints then
        params += "#{params.length > 0 ? '&' : '?'}waypoints=#{waypoints.join ';'}"
      end

      return params
    end

    def self.map_matching(waypoints, profile, options={})
      formatted_waypoints = waypoints.map {|p| xy_from_hash(p).join ','}.join ';'
      params = self.assemble_params(options)
      
      return request(
          :get,
          "/matching/v5/mapbox/#{profile}/#{formatted_waypoints}.json#{params}",
          nil)
    end
  end
end