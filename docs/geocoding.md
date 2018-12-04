# Geocoding

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
```