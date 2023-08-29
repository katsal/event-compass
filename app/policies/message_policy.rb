class MessagePolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

  def index?
    true # Any authenticated user can view messages
  end

  def create?
    true # Any authenticated user can create messages
  end
end
