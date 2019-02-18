module Mapbox
  class Optimization
    include Mapbox::APIOperations::Request
    extend Mapbox::HashUtils

    def self.assemble_params(options={})
      annotations = options[:annotations]
      approaches = options[:approaches]
      distributions = options[:distributions]
      radiuses = options[:radiuses]
      
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

      if distributions  then
        params += "#{params.length > 0 ? '&' : '?'}distributions=#{distributions.join(';')}"
      end

      if radiuses then
        params += "#{params.length > 0 ? '&' : '?'}radiuses=#{radiuses.join(';')}"
      end

      return params
    end

    def self.optimization(waypoints, profile, options={})
      formatted_waypoints = waypoints.map {|p| xy_from_hash(p).join ','}.join ';'
      params = self.assemble_params(options)
      
      return request(
          :get,
          "/optimized-trips/v1/mapbox/#{profile}/#{formatted_waypoints}.json#{params}",
          nil)
    end
  end
end