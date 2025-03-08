class LearningRoutePolicy < ApplicationPolicy
  # Learning Route Scope
  class Scope < ApplicationPolicy::Scope
    def resolve
      return scope.all if user.superadmin?
      scope_for_other_users
    end

    private

    def scope_for_other_users
      academy = user.academies.find_by(id: user.active_academy_id)
      return scope.none unless academy
      scope.where(academy: academy)
    end
  end

  def create?
    user.superadmin? || user_has_permission?
  end

  def show?
    user.superadmin? || user_has_permission?
  end

  def update?
    user.superadmin? || user_has_permission?
  end

  def destroy?
    user.superadmin? || user_has_permission?
  end

  private

  def user_has_permission?
    user_academy = UserAcademy.find_by(
      user_id: user.id,
      academy_id: record.academy_id
    )

    user_academy&.admin?
  end
end
