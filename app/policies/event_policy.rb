class EventPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
      user.admin? ? scope.all : scope.where(user: user)
    end
  end

  private

  def user_is_admin?
    user.admin
  end
end