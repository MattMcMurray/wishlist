class EmailAddressVerificationController < ApplicationController
  def show
  @user = User.find_by_email_address_verification_token(params[:token])

    if @user == Current.user
    @user.verify
      # handle response: JSON or redirect
    else
      # handle response: JSON or redirect
    end
  end

  def resend
  UserMailer.verify_email_address(Current.user).deliver_later

    # Handle response: JSON or redirect
  end
end
