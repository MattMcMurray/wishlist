class ListPolicy < ApplicationPolicy
  def create?
    true
  end

  def show?
    record.user_id == Current.user.id
  end

  def new?
    true
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.where(user_id: user.id)
    end
  end
end
