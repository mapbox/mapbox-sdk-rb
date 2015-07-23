module Mapbox
  class MapboxError < StandardError
  end

  class AuthenticationError < MapboxError
  end
end
