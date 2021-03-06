require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Booking
  class Application < Rails::Application
    
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    config.delete_posts_after_x_minutes = 2.days
    config.delete_activities_after_x_minutes = 3.days
    # config.force_ssl = true
    config.redis_server = 'redis://redis'
    config.active_job.queue_adapter = :sidekiq
    config.time_zone = "Hanoi"
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
