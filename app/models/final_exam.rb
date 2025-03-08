class FinalExam < Assessment
  validate :no_course_section_allowed

  private

  def no_course_section_allowed
    if course_section.present?
      errors.add(:course_section, 'no es permitido en un examen final')
    end
  end
end
