module Mapbox
  class Isochrone
    include Mapbox::APIOperations::Request
    extend Mapbox::HashUtils

    def self.assemble_params(options={})
      contours_minutes = options[:contours_minutes]
      contours_colors = options[:contours_colors]
      polygons = options[:polygons]
      denoise = options[:denoise]
      generalize = options[:generalize]
      
      params = ''
      opts = options.select { |key, value| key != :contours_minutes && key != :contours_colors }
      if opts.length > 0
        params += "#{params.length > 0 ? '&' : '?'}#{URI.encode_www_form(opts)}"
      end

      if contours_minutes  then
        params += "#{params.length > 0 ? '&' : '?'}contours_minutes=#{contours_minutes.join(',')}"
      end

      if contours_colors then
        params += "#{params.length > 0 ? '&' : '?'}contours_colors=#{contours_colors.join(',')}"
      end

      return params
    end

    def self.isochrone(profile, coordinates, options={})
      params = self.assemble_params(options)
      
      return request(
          :get,
          "/isochrone/v1/mapbox/#{profile}/#{coordinates}#{params}",
          nil)
    end
  end
end