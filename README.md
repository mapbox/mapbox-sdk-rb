# mapbox-sdk-ruby

The `mapbox-sdk` gem. A ruby interface to [Mapbox APIs](https://www.mapbox.com/developers/api/).

## Installation

```
gem install mapbox-sdk
```

## Services

* [Geocoding](https://www.mapbox.com/api-documentation/#geocoding): [docs](https://github.com/mapbox/mapbox-sdk-rb/blob/update-docs/docs/geocoding.md)
  * Forward (place names ⇢  longitude, latitude)
  * Reverse (longitude, latitude ⇢ place names)
* [Directions](https://www.mapbox.com/api-documentation/#directions): [docs](https://github.com/mapbox/mapbox-sdk-rb/blob/update-docs/docs/directions.md)
  * Profiles for driving, walking, and cycling
* [Tilequery](https://www.mapbox.com/api-documentation/#tilequery): [docs](https://github.com/mapbox/mapbox-sdk-rb/blob/update-docs/docs/tilequery.md)
* [Isochrone](https://www.mapbox.com/api-documentation/#isochrone): [docs](https://github.com/mapbox/mapbox-sdk-rb/blob/update-docs/docs/isochrone.md)
  * Profiles for driving, walking, and cycling

Heavily influenced by Stripe's Ruby client, and includes its MIT license.