# Settings specified here will take precedence over those in config/environment.rb

# The production environment is meant for finished, "live" apps.
# Code is not reloaded between requests
config.cache_classes = true

# Use a different logger for distributed setups
# config.logger = SyslogLogger.new

# Full error reports are disabled and caching is turned on
config.action_controller.consider_all_requests_local = false
config.action_controller.perform_caching             = true

# Enable serving of images, stylesheets, and javascripts from an asset server
config.action_controller.asset_host                  = "www.bonnes-ondes.fr"

# Disable delivery errors, bad email addresses will be ignored
# config.action_mailer.raise_delivery_errors = false

ActionController::CgiRequest::DEFAULT_SESSION_OPTIONS.update :session_domain => '.bonnes-ondes.fr'

Rubaidh::GoogleAnalytics.tracker_id = 'UA-1896598-5'
Rubaidh::GoogleAnalytics.environments = ['production']
Rubaidh::GoogleAnalytics.domain_name = 'bonnes-ondes.fr'
