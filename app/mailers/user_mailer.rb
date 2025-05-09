class UserMailer < ApplicationMailer
  def verify_email_address(user)
    @user = user

    MailerSend.create!(user:, sent_at: Time.zone.now)
    mail subject: "Verify your email", to: user.email_address

    true
  end
end
