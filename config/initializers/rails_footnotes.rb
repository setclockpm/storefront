defined?(Footnotes) && Footnotes.setup do |f|
  # Whether or not to enable footnotes
  f.enabled = Rails.env.development?
  # You can also use a lambda / proc to conditionally toggle footnotes
  # Example :
  # f.enabled = -> { User.current.admin? }
  # Beware of thread-safety though, Footnotes.enabled is NOT thread safe
  # and should not be modified anywhere else.

  # Only toggle some notes :
  # f.notes = [:session, :cookies, :params, :filters, :routes, :env, :queries, :log]
  f.notes = [:session, :cookies, :params, :routes]

  # Change the prefix :
  # f.prefix = 'mvim://open?url=file://%s&line=%d&column=%d'

  # Disable style :
  # f.no_style = true

  # Lock notes to top right :
  # f.lock_top_right = true

  # Change font size :
  # f.font_size = '11px'

  # Allow to open multiple notes :
  # f.multiple_notes = true
end


# Deface::Override.new(name:             'expand-form',
#                      virtual_path:     'spree/products/show',
#                      insert_before:    '[data-hook="product_description"]',
#                      text:             '<%= form_for :order, url: populate_orders_path do |f| %>',
#                      original:         'c01968edc48742a56f86dfd6415e7038ee7122d9')


# Deface::Override.new(name:             'remove-form-tag-for-expansion',
#                      virtual_path:     'spree/products/_cart_form',
#                      remove:           "erb[loud]:contains('form_for')",
#                      # text:             '<% end %>',
#                      original:         nil)