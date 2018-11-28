# Isochrone
```rb
isochrone = Mapbox::Isochrone.isochrone("walking", "-118.22258,33.99038", {contours_minutes: [5,10,15]})

# You must include the contours_minutes parameter, as well as a profile (walking, driving, cycling) and the center point coordinate.
# Optional parameters are contours_colors, polygons, denoise, and generalize. See more on the API documentation page.
```