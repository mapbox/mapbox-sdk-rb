[![Coverage Status](https://coveralls.io/repos/github/mapbox/mapbox-sdk-rb/badge.svg?branch=master)](https://coveralls.io/github/mapbox/mapbox-sdk-rb?branch=master)

# mapbox-sdk-ruby

The `mapbox-sdk` gem. A ruby interface to [Mapbox APIs](https://www.mapbox.com/developers/api/).

## Installation

```
gem install mapbox-sdk
```

## Services

* [Geocoding](https://docs.mapbox.com/api/search/) [[docs](https://github.com/mapbox/mapbox-sdk-rb/blob/master/docs/geocoding.md)]
  * Forward (place names ⇢  longitude, latitude)
  * Reverse (longitude, latitude ⇢ place names)
* [Directions](https://docs.mapbox.com/api/navigation/#directions): [[docs](https://github.com/mapbox/mapbox-sdk-rb/blob/master/docs/directions.md)]
  * Profiles for driving, driving-traffic, walking, and cycling
* [Tilequery](https://docs.mapbox.com/api/maps/#tilequery): [[docs](https://github.com/mapbox/mapbox-sdk-rb/blob/master/docs/tilequery.md)]
* [Isochrone](https://docs.mapbox.com/api/navigation/#isochrone): [[docs](https://github.com/mapbox/mapbox-sdk-rb/blob/master/docs/isochrone.md)]
  * Profiles for driving, walking, and cycling
* [Matrix](https://docs.mapbox.com/api/navigation/#matrix): [[docs](https://github.com/mapbox/mapbox-sdk-rb/blob/master/docs/matrix.md)]
  * Profiles for driving, driving-traffic, walking, and cycling
* [Map Matching](https://docs.mapbox.com/api/navigation/#map-matching): [[docs](https://github.com/mapbox/mapbox-sdk-rb/blob/master/docs/mapmatching.md)]
  * Profiles for driving, driving-traffic, walking, and cycling
* [Optimization](https://docs.mapbox.com/api/navigation/#optimization): [[docs](https://github.com/mapbox/mapbox-sdk-rb/blob/master/docs/optimization.md)]
  * Profiles for driving, driving-traffic, walking, and cycling

## Testing

You'll need to [create an access token](https://account.mapbox.com/access-tokens/create) in order to run tests.

Then you can run the entire test suite with the following command:

```
MapboxAccessToken=<YOUR_ACCESS_TOKEN> bundle exec ruby -Itest test/all_tests.rb
```

Heavily influenced by Stripe's Ruby client, and includes its MIT license.
