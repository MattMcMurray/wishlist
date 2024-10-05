class WishlistItemPolicy < ApplicationPolicy
  def new?
    true
  end

  def create?
    true
  end

  def show?
    record.user_id == Current.user.id
  end

  def update?
    record.user_id == Current.user.id
  end

  def destroy?
    record.user_id == Current.user.id
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.where(user_id: user.id)
    end
  end
end
