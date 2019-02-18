# Matrix

```rb
require "mapbox-sdk"
Mapbox.access_token = "YOUR_ACCESS_TOKEN"

# Return travel times between many points, passing in the required profile parameter.
matrix = Mapbox::Matrix.matrix([{
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

# For instance, to use the `annotations`, `approaches`, and `destinations` parameters:
matrix = Mapbox::Matrix.matrix([{
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
    approaches: ["curb","","curb"],
    destinations: [0,1]
  })

# In the above example, you can substitute `driving` for `driving-traffic`, `cycling` or `walking`. For more, [check out the documentation](https://www.mapbox.com/api-documentation/navigation/#matrix).
```