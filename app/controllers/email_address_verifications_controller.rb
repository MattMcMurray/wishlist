class EmailAddressVerificationsController < ApplicationController
  class EmailAddressVerificationError < StandardError; end

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
    UserMailer.verify_email_address(Current.user).deliver_later

    redirect_to root_url, notice: "Verification email sent"
  end
end
