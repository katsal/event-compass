class UserPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def show?
    # return record == user
    return true
  end

  def update?
    record.user == user
  end

def follow?
  return true
end

def unfollow?
  return true
end

end
