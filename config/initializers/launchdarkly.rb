Rails.configuration.client_side_id = Rails.application.credentials.launchdarkly&.dig(:client_side_id)

sdk_key = Rails.application.credentials.launchdarkly&.dig(:sdk_key)
Rails.configuration.client = LaunchDarkly::LDClient.new(sdk_key) if sdk_key.present?
