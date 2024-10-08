# frozen_string_literal: true

Sentry.init do |config|
  config.dsn = "https://80514efbc67ba25c9de9de51a12fdd17@o4508061652877312.ingest.us.sentry.io/4508061653139456"
  config.breadcrumbs_logger = [ :active_support_logger, :http_logger ]

  # Set traces_sample_rate to 1.0 to capture 100%
  # of transactions for tracing.
  # We recommend adjusting this value in production.
  # config.traces_sample_rate = 1.0
  # or
  # config.traces_sampler = lambda do |context|
  #   true
  # end

  # Set profiles_sample_rate to profile 100%
  # of sampled transactions.
  # We recommend adjusting this value in production.
  config.profiles_sample_rate = 1.0

  config.traces_sampler = lambda do |sampling_context|
    transaction_context = sampling_context[:transaction_context]

    op = transaction_context[:op]
    transaction_name = transaction_context[:name]

    case op
    when /http/
      case transaction_name
      when "/up"
        # ignore http trace for healthcheck requests to avoid noise in performance metrics
        0.0
      else
        1.0
      end
    else
      1.0
    end
  end
end
