class RegistrationsController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]
  before_action :resume_session, only: [ :new ]
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_session_url, alert: "Try again later." }

  def new
    authorize :registration
    redirect_to root_url if authenticated?
  end

  def create
    authorize :registration
    permitted = params.permit(:email_address, :password, :confirm_password)

    if permitted["password"] != permitted["confirm_password"]
      return redirect_to new_registration_url, alert: "Password confirmation does not match"
    end

    user = User.new(email_address: permitted["email_address"], password: permitted["password"])

    if user.save
      start_new_session_for user
      redirect_to after_authentication_url, notice: "Account created"
    else
      redirect_to new_registration_url, alert: user.errors.full_messages.to_sentence
    end
  end

  def destroy
    authorize :registration
    terminate_session
    redirect_to new_session_url
  end
end
