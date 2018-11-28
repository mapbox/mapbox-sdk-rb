# Tilequery

```rb
tilequery = Mapbox::Tilequery.tilequery(mapid, {location}, radius, limit)

# Example: tilequery = Mapbox::Tilequery.tilequery("mapbox.mapbox-streets-v7", {"longitude" => -100, "latitude" => 38}, 0, 1)
# `Radius` refers to the approximate distance in meters to query for features. Defaults to  0 if left blank. Has no upper bound. Required for queries against point and line data. 
# `Limit` refers to the number of features between  1 - 50 to return. Defaults to  5 if left blank.
```
