class StudentTask < ApplicationRecord
  belongs_to :course
  belongs_to :course_section, optional: true
  belongs_to :student, class_name: 'User'

  enum :status, {
    pending: 0,
    completed: 1,
    failed: 2
  }

  validates :status, presence: true
end
