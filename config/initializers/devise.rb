Devise.secret_key = "47ef632c291c9f885f1c07f20d466e2e24c0454f4c7d7bf78ca3f2c382139e4bebd4a2582883474dbe20c4421f1e60d62465"

Devise.setup do |config|
  # Required so users don't lose their carts when they need to confirm.
  config.allow_unconfirmed_access_for = 1.days

  # Fixes the bug where Confirmation errors result in a broken page.
  config.router_name = :spree

  # Add any other devise configurations here, as they will override the defaults provided by spree_auth_devise.
end
