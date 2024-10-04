class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :lists, dependent: :destroy
  has_many :list_shares, dependent: :destroy
  has_many :shared_withs, dependent: :destroy, class_name: "ListShare"

  normalizes :email_address, with: ->(e) { e.strip.downcase }
  validates :email_address, uniqueness: true, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end
