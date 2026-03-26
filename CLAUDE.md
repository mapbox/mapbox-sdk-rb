# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

`mapbox-sdk-rb` is a Ruby gem providing client bindings to Mapbox REST APIs. Services: Geocoding, Directions, Isochrone, Matrix, Map Matching, Optimization, and Tilequery.

## Commands

```bash
# Install dependencies
bundle install

# Run all tests
bundle exec rake test
# or
MapboxAccessToken=<token> bundle exec ruby -Itest test/all_tests.rb

# Run a single test file
MapboxAccessToken=<token> bundle exec ruby -Itest test/geocoding_test.rb
```

Tests require a valid `MapboxAccessToken` environment variable (real API token from account.mapbox.com).

## Architecture

**Entry point:** `lib/mapbox-sdk.rb` → loads `lib/mapbox.rb`

**`lib/mapbox.rb`** is the core module: holds `access_token`, configures the `rest-client` HTTP client, defines error handling (400/401/404/etc.), and exposes `Mapbox::APIOperations::Request` as a mixin.

**Service classes** (`lib/mapbox/*.rb`) each include `Mapbox::APIOperations::Request` and expose class methods (no instantiation). Coordinates are passed as `{longitude: x, latitude: y}` hashes; `Mapbox::HashUtils.xy_from_hash` converts them to `[lng, lat]` arrays for URL construction.

**Error hierarchy:** `Mapbox::MapboxError` → `Mapbox::AuthenticationError`

**Test pattern:** Test::Unit + Shoulda + Mocha. Each service has a corresponding `test/*_test.rb`. Tests make real HTTP calls, so a live token is required.

## Adding a New Service

1. Create `lib/mapbox/<service>.rb` — include `Mapbox::APIOperations::Request`, define class methods that call `execute_request`
2. Require it in `lib/mapbox.rb`
3. Create `test/<service>_test.rb` and require it in `test/all_tests.rb`
4. Add docs in `docs/<service>.md`
