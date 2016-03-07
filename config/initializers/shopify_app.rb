ShopifyApp.configure do |config|
  config.api_key = "5709921f9b8fd85e72ffb00174d78b1b"
  config.secret = "5b62dcbdf1a1e260c13fe6999236a36f"
  config.redirect_uri = "http://localhost:3000/auth/shopify/callback"
  config.scope = "read_orders, read_products"
  config.embedded_app = true
end
