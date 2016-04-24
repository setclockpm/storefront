Porthos::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false
  config.eager_load = false

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Expands the lines which load the assets
  # config.assets.debug = true
  # Recommended By Spree
  config.assets.debug = false
  
  # Added when Devise was installed
  config.action_mailer.default_options = { from: 'no-reply@porthoshome.com' }
  config.action_mailer.default_url_options = { host: 'localhost:3000' }
  config.action_mailer.perform_deliveries = true
  config.action_mailer.preview_path = "#{Rails.root}/lib/mailer_previews"
  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = true
  
  
  config.action_mailer.smtp_settings = {
    address: "localhost",
    port: 25,
    domain: "porthoshome.com",
  }
end


# SMTP server (i.e., outgoing mail): smtp.gmail.com
# SMTP username: Your full Gmail or Google Apps email address (e.g. example@gmail.com or example@yourdomain.com)
# SMTP password: Your Gmail or Google Apps email password
# SMTP port: 465
# SMTP TLS/SSL required: yes
# In order to store a copy of outgoing emails in your Gmail or Google Apps Sent folder, log into your Gmail or Google Apps email Settings and:
# Click on the Forwarding/IMAP tab and scroll down to the IMAP Access section: IMAP must be enabled in order for emails to be properly copied to your sent folder.
#


