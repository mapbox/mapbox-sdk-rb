module Mapbox
  class Matrix
    include Mapbox::APIOperations::Request
    extend Mapbox::HashUtils

    def self.assemble_params(options={})
      annotations = options[:annotations]
      approaches = options[:approaches]
      if options[:destinations].kind_of?(Array)
        destinations = options[:destinations]
      end
      sources = options[:sources]
      
      params = ''
      opts = options.select { |key, value| key!= :annotations && key != :approaches && key != :destinations && key != :sources  }
      if opts.length > 0
        params += "#{params.length > 0 ? '&' : '?'}#{URI.encode_www_form(opts)}"
      end

      if annotations  then
        params += "#{params.length > 0 ? '&' : '?'}annotations=#{annotations.join(',')}"
      end

      if approaches  then
        params += "#{params.length > 0 ? '&' : '?'}approaches=#{approaches.join(';')}"
      end

      if destinations then
        params += "#{params.length > 0 ? '&' : '?'}destinations=#{destinations.join(';')}"
      end

      if sources then
        params += "#{params.length > 0 ? '&' : '?'}sources=#{sources.join(';')}"
      end

      return params
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