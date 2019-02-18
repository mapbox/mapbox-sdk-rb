# Optimization

```rb
require "mapbox-sdk"
Mapbox.access_token = "YOUR_ACCESS_TOKEN"

# Returns a duration-optimized route between coordinates with required profile parameter.
optimization = Mapbox::Optimization.optimization([{
  "longitude" => -122.42,
  "latitude" => 37.78
}, {
  "longitude" => -122.45,
  "latitude" => 37.91
}, {
 "longitude" => -122.48,
  "latitude" => 37.73
  }], "walking")

# To provide query parameters to the Matrix API, such as `annotations`, `approaches` or `sources`, add those in a Hash as third parameter (find the full list of parameters (here)[https://www.mapbox.com/api-documentation/navigation/#matrix]).

# For instance, to use the `annotations`, `approaches`, and `overview` parameters:
optimization = Mapbox::Optimization.optimization([{
  "longitude" => -122.42,
  "latitude" => 37.78
}, {
  "longitude" => -122.45,
  "latitude" => 37.91
}, {
 "longitude" => -122.48,
  "latitude" => 37.73
  }], "cycling", {
    annotations: ["duration", "distance"],
    approaches: ["curb","curb","curb"],
    overview: "false"
  })

# The bearings param works a bit differently. Here's an example, leaving the second bearing blank with an additional `;` character (you must include the same number of bearings as waypoints, per the docs):
optimization = Mapbox::Optimization.optimization([{
  "longitude" => -122.42,
  "latitude" => 37.78
}, {
  "longitude" => -122.45,
  "latitude" => 37.91
}, {
 "longitude" => -122.48,
  "latitude" => 37.73
  }], "driving", {
    bearings: "45,90;;90,1"
  })

# In the above example, you can substitute `driving` for `driving-traffic`, `cycling` or `walking`. For more, [check out the documentation](https://docs.mapbox.com/api/navigation/#optimization).
```