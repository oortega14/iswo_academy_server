# Define Lesson Model
class Lesson < ApplicationRecord
  # acts_as_list gem
  acts_as_list scope: :course_section

  # Associations
  has_many :comments, as: :commentable, dependent: :destroy

  has_many :lesson_progresses
  has_many :users, through: :lesson_progresses

  has_many :attachments, as: :attachable, dependent: :destroy
  has_many :file_attachments, -> { file_attachments }, as: :attachable, class_name: 'Attachment'
  has_many :url_attachments, -> { url_attachments }, as: :attachable, class_name: 'Attachment'

  belongs_to :course_section

  # Validations
  validates :title, presence: true
  validates :description, presence: true

  # Nested forms
  accepts_nested_attributes_for :attachments, allow_destroy: true

  # Callbacks
  # after_create :create_student_trackers

  private

  # def create_student_trackers
  #   students = Student.where(course_id: course_section.course.id)
  #   students.each do |student|
  #     UserLessonTracker.create!(user_id: student.user_id, lesson_id: id, status: 0)
  #   end
  # end
end
