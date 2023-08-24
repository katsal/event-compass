class UserPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def show?
    true
  end

  def user_is_admin?
    user.admin
  end

  def user_is_curent_user?
    user == current_user
  end

end
