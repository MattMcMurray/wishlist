module UserAttributable
  extend ActiveSupport::Concern

  included do
    belongs_to :user
    before_validation :set_created_by
  end

  private

  def set_created_by
    self.user_id ||= Current.user.id if new_record? && Current.user.present?
  end
end
