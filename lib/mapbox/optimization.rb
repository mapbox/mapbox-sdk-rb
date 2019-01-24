module Mapbox
  class Optimization
    include Mapbox::APIOperations::Request
    extend Mapbox::HashUtils

    def self.assemble_params(options={})
      annotations = options[:annotations]
      approaches = options[:approaches]
      bearings = options[:bearings]
      destination = options[:destination]
      distributions = options[:distributions]
      geometries = options[:geometries]
      language = options[:language]
      overview = options[:overview]
      radiuses = options[:radiuses]
      source = options[:source]
      steps = options[:steps]
      roundtrip = options[:roundtrip]
      
      params = ''
      opts = options.select { |key, value| key != :annotations && key != :approaches && key != :distributions && key != :radiuses }
      if opts.length > 0
        params += "#{params.length > 0 ? '&' : '?'}#{URI.encode_www_form(opts)}"
      end

      if annotations  then
        params += "#{params.length > 0 ? '&' : '?'}annotations=#{annotations.join(',')}"
      end

      if approaches  then
        params += "#{params.length > 0 ? '&' : '?'}approaches=#{approaches.join(';')}"
      end

      # this one is weird - Takes 2 values per waypoint: an angle clockwise from true north between 0 and 360, and the range of degrees by which the angle can deviate (recommended value is 45° or 90°), formatted as {angle, degrees}. If provided, the list of bearings must be the same length as the list of waypoints. However, you can skip a coordinate and show its position in the list with the ; separator.
      if bearings  then
        params += "#{params.length > 0 ? '&' : '?'}bearings=#{bearings.join(';')}"
      end

      if distributions  then
        params += "#{params.length > 0 ? '&' : '?'}distributions=#{distributions.join(';')}"
      end

      if radiuses then
        params += "#{params.length > 0 ? '&' : '?'}radiuses=#{radiuses.join(';')}"
      end

      if timestamps then
        params += "#{params.length > 0 ? '&' : '?'}timestamps=#{timestamps.join(';')}"
      end

      if waypoint_names then
        params += "#{params.length > 0 ? '&' : '?'}waypoint_names=#{waypoint_names.join(';')}"
      end

      if waypoints then
        params += "#{params.length > 0 ? '&' : '?'}waypoints=#{waypoints.join(';')}"
      end

      return params
    end

    def self.map_matching(waypoints, profile, options={})
      formatted_waypoints = waypoints.map {|p| wxy_from_hash(p).join ','}.join ';'
      params = self.assemble_params(options)
      
      return request(
          :get,
          "/optimized-trips/v1/mapbox/#{profile}/#{formatted_waypoints}.json#{params}",
          nil)
    end
  end
end