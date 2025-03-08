class Course < ApplicationRecord
  # Associated blobs
  has_one_attached :banner
  has_one_attached :promotional_image

  # Associations
  has_many :course_details, dependent: :destroy
  has_many :course_benefits, -> { where(type: 'CourseBenefit') }, class_name: 'CourseDetail'
  has_many :course_goals, -> { where(type: 'CourseGoal') }, class_name: 'CourseDetail'

  has_many :assessments, dependent: :destroy
  has_many :quizzes, -> { quizzes }, class_name: 'Assessment'
  has_one :final_exam, -> { final_exams }, class_name: 'Assessment'

  has_many :attachments, as: :attachable, dependent: :destroy
  has_many :file_attachments, -> { file_attachments }, as: :attachable, class_name: 'Attachment'
  has_many :url_attachments, -> { url_attachments }, as: :attachable, class_name: 'Attachment'

  has_many :course_sections, dependent: :destroy

  has_many :reviews, dependent: :destroy
  has_many :teacher_tasks, dependent: :destroy
  has_many :student_tasks, dependent: :destroy
  has_many :enrollments, dependent: :destroy

  has_one :certificate, dependent: :destroy
  has_one :certificate_configuration, dependent: :destroy

  # has_many :payment_items, dependent: :destroy

  belongs_to :academy
  belongs_to :creator, class_name: 'User'

  has_and_belongs_to_many :learning_routes

  # Validations
  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true

  # Enums
  enum :status, {
    draft: 0,
    published: 1,
    almost_finished: 2,
    archived: 3
  }

  # Nested attributes
  accepts_nested_attributes_for :course_benefits, allow_destroy: true
  accepts_nested_attributes_for :course_goals, allow_destroy: true
  accepts_nested_attributes_for :attachments, allow_destroy: true
end
