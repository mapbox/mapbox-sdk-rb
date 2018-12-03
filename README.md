[![Coverage Status](https://coveralls.io/repos/github/mapbox/mapbox-sdk-rb/badge.svg?branch=master)](https://coveralls.io/github/mapbox/mapbox-sdk-rb?branch=master)

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
* [Isochrone](https://www.mapbox.com/api-documentation/#isochrone)
  * Profiles for driving, walking, and cycling

## Examples

```rb
require "mapbox-sdk"
Mapbox.access_token = "YOUR_ACCESS_TOKEN"

# Reverse geocoding
placenames = Mapbox::Geocoder.geocode_reverse({
  "latitude": 38,
  "longitude": -100
})

# Forward geocoding with optional proximity parameter
places = Mapbox::Geocoder.geocode_forward("Chester, NJ", {:proximity => {:longitude => -74.6968, :latitude => 40.7843}})

# Driving directions with required profile parameter.
drivingDirections = Mapbox::Directions.directions([{
  "longitude" => -100,
  "latitude" => 38
}, {
  "longitude" => -90,
  "latitude" => 38
  }], "driving")

# To provide query parameters to the Directions API, such as `geometries`, `language` or `steps`, add those in a Hash as third parameter (find the full list of parameters (here)[https://www.mapbox.com/api-documentation/#retrieve-directions]).

# For instance, to use the `geometries` and `voice_instructions` parameter:
drivingDirections = Mapbox::Directions.directions([{
  "longitude" => -100,
  "latitude" => 38
}, {
  "longitude" => -90,
  "latitude" => 38
  }], "driving", {
    geometries: "geojson",
    voice_instructions: true
  })
  
# In the above example, you can substitute `driving` for `driving-traffic`, `cycling` or `walking`. For more, [check out the documentation](https://www.mapbox.com/api-documentation/#directions).

# Tilequery
tilequery = Mapbox::Tilequery.tilequery(mapid, {location}, radius, limit)

# Example: tilequery = Mapbox::Tilequery.tilequery("mapbox.mapbox-streets-v7", {"longitude" => -100, "latitude" => 38}, 0, 1)
# `Radius` refers to the approximate distance in meters to query for features. Defaults to  0 if left blank. Has no upper bound. Required for queries against point and line data. 
# `Limit` refers to the number of features between  1 - 50 to return. Defaults to  5 if left blank.

# Isochrone
isochrone = Mapbox::Isochrone.isochrone("walking", "-118.22258,33.99038", {contours_minutes: [5,10,15]})

# You must include the contours_minutes parameter, as well as a profile (walking, driving, cycling) and the center point coordinate.
# Optional parameters are contours_colors, polygons, denoise, and generalize. See more on the API documentation page.
```

Heavily influenced by Stripe's Ruby client, and includes its MIT license.
