module Mapbox
  class Directions
    include Mapbox::APIOperations::Request
    extend Mapbox::HashUtils

    def self.assemble_params(options={})
      alternatives = options[:alternatives]
      annotations = options[:annotations]
      approaches = options[:approaches]
      banner_instructions = options[:banner_instructions]
      bearings = options[:bearings]
      continue_straight = options[:continue_straight]
      exclude = options[:exclude]
      geometries = options[:geometries]
      language = options[:language]
      overview = options[:overview]
      radiuses = options[:radiuses]
      roundabout_exits = options[:roundabout_exits]
      steps = options[:steps]
      voice_instructions = options[:voice_instructions]
      voice_units = options[:voice_units]
      waypoint_names = options[:waypoint_names]
      
      params = ''
      opts = options.select { |key, value| key != :approaches && key != :bearings && key != :radiuses && key != :waypoint_names  }
      if opts.length > 0
        params += "#{params.length > 0 ? '&' : '?'}#{URI.encode_www_form(opts)}"
      end

      if approaches  then
        params += "#{params.length > 0 ? '&' : '?'}approaches=#{approaches.join(';')}"
      end

      if bearings then
        params += "#{params.length > 0 ? '&' : '?'}bearings=#{bearings.map {|p| bearings.join ','}.join ';'}"
      end

      if radiuses then
        params += "#{params.length > 0 ? '&' : '?'}radiuses=#{radiuses.join ';'}"
      end

      if waypoint_names then
        params += "#{params.length > 0 ? '&' : '?'}waypoint_names=#{waypoint_names.join ';'}"
      end

      return params
    end

    def self.directions(waypoints, profile, options={})
      formatted_waypoints = waypoints.map {|p| xy_from_hash(p).join ','}.join ';'
      params = self.assemble_params(options)

      print "/directions/v5/mapbox/#{profile}/#{formatted_waypoints}.json#{params}"
      
      return request(
          :get,
          "/directions/v5/mapbox/#{profile}/#{formatted_waypoints}.json#{params}",
          nil)
    end
  end
end