Sentry.init do |config|
  config.dsn = ENV["SENTRY_DSN"]
  config.breadcrumbs_logger = [:active_support_logger, :http_logger]

  # Set traces_sample_rate to 1.0 to capture 100%
  # of transactions for tracing.
  # We recommend adjusting this value in production.
  config.traces_sample_rate = ENV.fetch("SENTRY_TRACES_SAMPLE_RATE", 0.1).to_f

  # Set profiles_sample_rate to profile 100%
  # of sampled transactions.
  # We recommend adjusting this value in production.
  config.profiles_sample_rate = ENV.fetch("SENTRY_PROFILES_SAMPLE_RATE", 0.1).to_f

  # Filter out sensitive data
  config.before_send = lambda do |event, hint|
    # Filter sensitive parameters
    if event.request
      event.request.data = event.request.data&.except(
        "password",
        "password_confirmation",
        "current_password",
        "secret",
        "token",
        "api_key"
      )
    end
    event
  end

  # Set the environment
  config.environment = Rails.env

  # Enable release tracking (optional - requires git)
  # config.release = `git rev-parse HEAD`.strip rescue nil
end
