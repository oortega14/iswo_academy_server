# User policy
class UserPolicy < ApplicationPolicy
  # User Scope
  class Scope < ApplicationPolicy::Scope
    def resolve
      return scope.all if user.is_super_admin?
      return scope_for_admin if user.admin?
      return scope_for_teacher if user.teacher?

      scope.none
    end

    private

    def scope_for_admin
      scope.joins(:course).where(courses: { academy_id: user.academy&.id })
    end

    def scope_for_teacher
      scope.joins(:course).where(courses: { teacher_id: user.id })
    end
  end

  def show?
    user_has_access?
  end

  def create?
    !user.student? && user_has_access?
  end

  def update?
    !user.student? && user_has_access?
  end

  def destroy?
    !user.student? && user_has_access?
  end

  def user_courses?
    record.first&.user_id == user.id
  end

  private

  def user_has_access?
    return false unless record.present?
    return true if user.superadmin?
    return true if admin_access?
    return true if teacher_access?
    return true if student_access?

    false
  end

  def admin_access?
    user.admin? && record.course.academy_id == user.academy.id
  end

  def teacher_access?
    user.teacher? && record.course.teacher_id == user.id
  end

  def student_access?
    user.student? && record.present?
  end
end
