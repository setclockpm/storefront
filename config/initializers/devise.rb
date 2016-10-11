#Devise.secret_key = ENV['DEVISE_SECRET_KEY']
Devise.secret_key = '2a6e151b4f7b580487a302dd18092e3ae6104d191f6b29207f36af7c81ab3910e5f417059887cbd6331477d420907d0f569ed868f5cf48a24456a3b1908b8e36'

Devise.setup do |config|
  # Required so users don't lose their carts when they need to confirm.
  config.allow_unconfirmed_access_for = 1.days

  # Fixes the bug where Confirmation errors result in a broken page.
  config.router_name = :spree

  # Add any other devise configurations here, as they will override the defaults provided by spree_auth_devise.
end
