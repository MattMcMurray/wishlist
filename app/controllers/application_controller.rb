class ApplicationController < ActionController::Base
  include Authentication
  include Pundit::Authorization

  after_action :verify_pundit_authorization

  before_action :set_user_context

  def verify_pundit_authorization
    return true if ENV["SKIP_PUNDIT_VERIFICATION"]

    if action_name == "index"
      verify_policy_scoped
    else
      verify_authorized
    end
  end

  def set_user_context
    return if Current.user.nil?

    @context = LaunchDarkly::LDContext.create({
      key: Current.user.id.to_s,
      kind: "user",
      name: Current.user.email_address,
      groups: []
    })
  end

  # TODO: uncomment
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  # allow_browser versions: :modern
end
