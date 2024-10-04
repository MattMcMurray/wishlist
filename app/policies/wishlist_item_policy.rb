class WishlistItemPolicy < ApplicationPolicy
  def new?
    true
  end

  def create?
    true
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.where(user_id: user.id)
    end
  end
end
