class LessonPolicy < ApplicationPolicy
  # Lesson Scope
  class Scope < ApplicationPolicy::Scope
    def resolve
      return scope.all if user.is_super_admin?
      scope_for_other_users
    end

    private

    def scope_for_other_users
      academy = user.academies.find_by(id: user.active_academy_id)
      return scope.none unless academy

      scope.joins(course_section: :course).where(courses: { academy: academy })
    end
  end

  def show?
    user.superadmin? || user_has_permission? || student_enrolled?
  end

  def create?
    user.superadmin? || user_has_permission?
  end

  def update?
    user.superadmin? || user_has_permission?
  end

  def destroy?
    user.superadmin? || user_has_permission?
  end

  def move_up?
    user.superadmin? || user_has_permission?
  end

  def move_down?
    user.superadmin? || user_has_permission?
  end

  def update_visibility?
    user.superadmin? || user_has_permission?
  end

  def user_courses?
    record.first&.user_id == user.id
  end

  private

  def user_has_permission?
    user_academy = UserAcademy.find_by(
      user_id: user.id,
      academy_id: record.course_section.course.academy_id
    )

    user_academy&.admin? || user_academy&.professor?
  end

  def student_enrolled?
    user.enrollments.where(course_id: record.course_section.course_id, status: 'purchased').exists?
  end
end
