# Tokens

```rb
require "mapbox-sdk"
Mapbox.access_token = "YOUR_ACCESS_TOKEN"

# Get token
token = Mapbox::Tokens.get_token

# List token's scopes
scopes = Mapbox::Tokens.list_scopes("YOUR_USERNAME")

# List all tokens (your token must have the 'tokens:read' scope)
tokens = Mapbox::Tokens.list_tokens("YOUR_USERNAME")

# List only default public token
default_token = Mapbox::Tokens.list_tokens("YOUR_USERNAME", {:default => true})

# List tokens except default public token
tokens = Mapbox::Tokens.list_tokens("YOUR_USERNAME", {:default => false})

# List public tokens
public_tokens = Mapbox::Tokens.list_tokens("YOUR_USERNAME", {:usage => 'pk'})

# List secret tokens
secret_tokens = Mapbox::Tokens.list_tokens("YOUR_USERNAME", {:usage => 'sk'})

# Create a public token (your existing token must have the 'tokens:read' & 'tokens:write' scopes in addition to any scopes you intend to set on your new token)
public_token = Mapbox::Tokens.create_token("YOUR_USERNAME", "auto-generated public token", ["styles:tiles", "styles:read", "fonts:read", "datasets:read", "vision:read"])

# Create a public token with use restricted to a particular domain name
public_token = Mapbox::Tokens.create_token("YOUR_USERNAME", "auto-generated public token", ["styles:tiles", "styles:read", "fonts:read", "datasets:read", "vision:read"], ["example.com"])

# Create a secret token (your existing token must have the 'tokens:read' & 'tokens:write' scopes in addition to any scopes you intend to set on your new token)
public_token = Mapbox::Tokens.create_token("YOUR_USERNAME", "auto-generated secret token", ["scopes:list", "tokens:read", "tokens:write"])

# Delete a token
Mapbox::Tokens.delete_token("YOUR_USERNAME", "TOKEN_ID")

# Update a public token's name/note & scopes (no "vision:read" scope)
updated_token = Mapbox::Tokens.update_token("YOUR_USERNAME", "TOKEN_ID", "updated token", ["styles:tiles", "styles:read", "fonts:read", "datasets:read"])

# Update a public token's name/note, scopes, and allowed URLs
updated_token = Mapbox::Tokens.update_token("YOUR_USERNAME", "TOKEN_ID", "updated token", ["styles:tiles", "styles:read", "fonts:read", "datasets:read"], ["example.com"])
```