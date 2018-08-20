# mapbox-sdk-ruby

The `mapbox-sdk` gem. A ruby interface to [Mapbox APIs](https://www.mapbox.com/developers/api/).

## Installation

```
gem install mapbox-sdk
```

## Services

* [Geocoding](https://www.mapbox.com/api-documentation/#geocoding)
  * Forward (place names ⇢  longitude, latitude)
  * Reverse (longitude, latitude ⇢ place names)
* [Directions](https://www.mapbox.com/api-documentation/#directions)
  * Profiles for driving, walking, and cycling
* [Tilequery](https://www.mapbox.com/api-documentation/#tilequery)

## Example

```rb
require "mapbox-sdk"
Mapbox.access_token = "YOUR_ACCESS_TOKEN"

# Reverse geocoding
placenames = Mapbox::Geocoder.geocode_reverse({
  "latitude" => 38,
  "longitude" => -100
})

# Forward geocoding with optional proximity parameter
places = Mapbox::Geocoder.geocode_forward("Chester, NJ", {:proximity => {:longitude => -74.6968, :latitude => 40.7843}})

# Driving directions with required profile parameter. The third parameter is optional.
drivingDirections = Mapbox::Directions.directions([{
  "longitude" => -100,
  "latitude" => 38
}, {
  "longitude" => -90,
  "latitude" => 38
  }], "driving", {
  "geometries": "geojson"
})
  
# In the above example, you can substitute `driving` for `driving-traffic`, `cycling` or `walking`. For more, [check out the documentation](https://www.mapbox.com/api-documentation/#directions).

# Tilequery
tilequery = Mapbox::Tilequery.tilequery(mapid, {location}, radius, limit)

# Example: tilequery = Mapbox::Tilequery.tilequery("mapbox.mapbox-streets-v7", {"longitude" => -100, "latitude" => 38}, 0, 1)
# `Radius` refers to the approximate distance in meters to query for features. Defaults to  0 if left blank. Has no upper bound. Required for queries against point and line data. 
# `Limit` refers to the number of features between  1 - 50 to return. Defaults to  5 if left blank.
```

Heavily influenced by Stripe's Ruby client, and includes its MIT license.
