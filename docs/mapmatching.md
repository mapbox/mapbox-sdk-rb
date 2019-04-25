# Map Matching

```rb
require "mapbox-sdk"
Mapbox.access_token = "YOUR_ACCESS_TOKEN"

# Snap fuzzy, inaccurate GPS or phone traces to the road and path network with required profile parameter.
matching = Mapbox::MapMatching.map_matching([{
  "longitude" => -117.17282,
  "latitude" => 32.71204
}, {
  "longitude" => -117.17288,
  "latitude" => 32.71225
}, {
  "longitude" => -117.17293,
  "latitude" => 32.71244
  },{
  "longitude" => -117.17292,
  "latitude" => 32.71256
  }], "driving")

# To provide query parameters to the Matrix API, such as `annotations`, `approaches` or `sources`, add those in a Hash as third parameter (find the full list of parameters (here)[https://www.mapbox.com/api-documentation/navigation/#matrix]).

# For instance, to use the `geometries` and `voice_instructions` parameter:
matching = Mapbox::MapMatching.map_matching([{
  "longitude" => -117.17282,
  "latitude" => 32.71204
}, {
  "longitude" => -117.17288,
  "latitude" => 32.71225
}, {
  "longitude" => -117.17293,
  "latitude" => 32.71244
  },{
  "longitude" => -117.17292,
  "latitude" => 32.71256
  }], "driving", {
    annotations: ["duration", "distance", "speed"],
    approaches: ["curb","curb","curb","curb"]
  })

# In the above example, you can substitute `driving` for `driving-traffic`, `cycling` or `walking`. For more, [check out the documentation](https://docs.mapbox.com/api/navigation/#map-matching).
```