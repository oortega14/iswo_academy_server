class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(id: user.id)
    end
  end
end
