Rails.configuration.client_side_id = Rails.application.credentials.launchdarkly[:client_side_id]
Rails.configuration.client = LaunchDarkly::LDClient.new(Rails.application.credentials.launchdarkly[:sdk_key])
