class StudentResponse < ApplicationRecord
  # Associations
  belongs_to :student_assessment
  belongs_to :question
  belongs_to :question_option, optional: true

  # Callbacks
  before_save :evaluate_correctness

  # Methods
  private

  def evaluate_correctness
    self.correct = if question.multiple_choice?
      question_option&.correct || false
    elsif question.true_false?
      answer_text.to_s.downcase == 'true'
    else
      false
    end
  end
end
