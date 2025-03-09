class EnrollmentPolicy < ApplicationPolicy
  # Enrollment Scope
  class Scope < ApplicationPolicy::Scope
    def resolve
      if user.superadmin?
        scope.all
      else
        academy = user.academies.find_by(id: user.active_academy_id)
        return scope.none unless academy

        scope.joins(:course).where(courses: { academy: academy })
      end
    end
  end

  def show?
    user.superadmin? || owner? || admin_or_teacher?
  end

  def create?
    user.superadmin? || admin_or_teacher?
  end

  def update?
    user.superadmin? || admin_or_teacher?
  end

  def destroy?
    user.superadmin? || admin_or_teacher?
  end

  def move_up?
    user.superadmin? || user_has_permission?
  end

  def move_down?
    user.superadmin? || user_has_permission?
  end

  private

  def owner?
    record.user_id == user.id
  end

  def admin_or_teacher?
    user_academy = UserAcademy.find_by(
      user_id: user.id,
      academy_id: record.course.academy_id
    )

    user_academy&.admin? || user_academy&.teacher?
  end

  def user_has_permission?
    user_academy = UserAcademy.find_by(
      user_id: user.id,
      academy_id: record.course.academy_id
    )

    user_academy&.admin? || user_academy&.teacher?
  end
end
