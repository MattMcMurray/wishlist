class User < ApplicationRecord
  include EmailAddressVerification

  has_secure_password
  has_email_address_verification

  has_many :sessions, dependent: :destroy
  has_many :lists, dependent: :destroy
  has_many :list_shares, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }
  validates :email_address, uniqueness: true, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end
