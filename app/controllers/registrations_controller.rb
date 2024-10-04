class RegistrationsController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]
  before_action :resume_session, only: [ :new ]
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_session_url, alert: "Try again later." }

  def new
    authorize :registrations
    redirect_to root_url if authenticated?
  end

  def create
    authorize :registrations
    user = User.new(params.permit(:email_address, :password))

    if user.save
      start_new_session_for user
      redirect_to after_authentication_url, notice: "Account created"
    else
      redirect_to new_registration_url, alert: user.errors.full_messages.to_sentence
    end
  end

  def destroy
    authorize :registrations
    terminate_session
    redirect_to new_session_url
  end
end
