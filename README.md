[![Coverage Status](https://coveralls.io/repos/github/mapbox/mapbox-sdk-rb/badge.svg?branch=master)](https://coveralls.io/github/mapbox/mapbox-sdk-rb?branch=master)

# mapbox-sdk-ruby

The `mapbox-sdk` gem. A ruby interface to [Mapbox APIs](https://www.mapbox.com/developers/api/).

## Installation

```
gem install mapbox-sdk
```

## Services

* [Geocoding](https://www.mapbox.com/api-documentation/search/#geocoding) [[docs](https://github.com/mapbox/mapbox-sdk-rb/blob/master/docs/geocoding.md)]
  * Forward (place names ⇢  longitude, latitude)
  * Reverse (longitude, latitude ⇢ place names)
* [Directions](https://www.mapbox.com/api-documentation/navigation/#directions): [[docs](https://github.com/mapbox/mapbox-sdk-rb/blob/master/docs/directions.md)]
  * Profiles for driving, walking, and cycling
* [Tilequery](https://www.mapbox.com/api-documentation/maps/#tilequery): [[docs](https://github.com/mapbox/mapbox-sdk-rb/blob/master/docs/tilequery.md)]
* [Isochrone](https://www.mapbox.com/api-documentation/navigation/#isochrone): [[docs](https://github.com/mapbox/mapbox-sdk-rb/blob/masterdocs/isochrone.md)]
  * Profiles for driving, walking, and cycling

## Testing

Run `bundle exec ruby -Itest test/all_tests.rb` or individual tests as needed.

Heavily influenced by Stripe's Ruby client, and includes its MIT license.
