class Quiz < Assessment
  # Validations
  validates :course_section, presence: true
end
