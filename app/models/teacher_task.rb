# TeacherTask Model
class TeacherTask < ApplicationRecord
  # Additional Gems
  acts_as_paranoid

  # Associations
  belongs_to :course
  belongs_to :course_section, optional: true
  belongs_to :teacher, class_name: 'User'

  has_many :student_tasks, dependent: :destroy
  has_many :student_task_comments, through: :student_tasks

  has_many :attachments, as: :attachable, dependent: :destroy
  has_many :file_attachments, -> { file_attachments }, as: :attachable, class_name: 'Attachment'
  has_many :url_attachments, -> { url_attachments }, as: :attachable, class_name: 'Attachment'

  # Callbacks
  # after_create :assign_tasks_to_students

  # Enums
  enum :status, { created: 0, assigned: 1, expired: 2, completed: 3 }

  # Scopes
  scope :obsoletes, -> { only_deleted }
  scope :all_with_obsoletes, -> { unscoped }

  # Validations
  validates :title, :description, :due_date, :course, presence: true
  validate :course_or_section_present

  # Nested Attributes
  accepts_nested_attributes_for :attachments, allow_destroy: true

  private

  def course_or_section_present
    return unless course_section_id.blank? && course_id.blank?

    errors.add(:base, 'Tarea debe estar asociada a un curso o una sección.')
  end

  def assign_tasks_to_students
    Tasks::TaskService.assign_tasks(id, course_id)
  end
end
