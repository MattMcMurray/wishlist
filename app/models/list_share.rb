class ListShare < ApplicationRecord
  belongs_to :user
  belongs_to :list
  belongs_to :shared_with, class_name: "User"

  enum share_type: [ :public_link, :user ]

  before_create :assign_uuid

  def assign_uuid
    self.id = SecureRandom.uuid if self.id.blank?
  end
end
