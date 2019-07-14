Sidekiq.configure_server do |config|
    config.redis = { url: Rails.configuration.redis_server }
end
  
Sidekiq.configure_client do |config|
    config.redis = { url: Rails.configuration.redis_server }
end