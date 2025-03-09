class CourseSection < ApplicationRecord
  # acts_as_list gem
  acts_as_list

  # Associations
  has_many :quizzes, -> { quizzes }, class_name: 'Assessment', dependent: :destroy
  has_many :lessons, dependent: :destroy

  belongs_to :course
end
