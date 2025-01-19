class EmailAddressVerificationsController < ApplicationController
  class EmailAddressVerificationError < StandardError; end
  MINUTES_BETWEEN_SENDS = 15

  skip_before_action :redirect_if_user_unverified

  def show
    @user = User.find_by_email_address_verification_token(params[:token])

    if @user == Current.user
    @user.verify
      redirect_to root_url, notice: "Email address verified"
    else
      raise EmailAddressVerificationError, "Invalid token"
    end
  end

  def resend
    last_send = MailerSend.where(user: Current.user).last

    minutes_since_last_send = last_send.present? ? ((Time.zone.now - last_send.sent_at) / 60).to_i : nil
    if minutes_since_last_send.present? && minutes_since_last_send < MINUTES_BETWEEN_SENDS
      flash[:alert] = "Verification email sent recently. Please wait #{MINUTES_BETWEEN_SENDS - minutes_since_last_send} minutes before trying again."
    else
      UserMailer.verify_email_address(Current.user).deliver_later
      flash[:notice] = "Verification email sent"
    end

    redirect_to root_url
  end

  def unverified
    redirect_to root_url if Current.user&.verified_at.present?
  end
end
