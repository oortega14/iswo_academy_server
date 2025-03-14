class QuestionSerializer < BaseSerializer
  def serializable_hash
    case context[:view]
    when :summary
      summary_hash
    else
      full_hash
    end
  end

  private

  # Full Hash response
  def full_hash
    {
      id: resource.id,
      assessment_id: resource.assessment_id,
      content: resource.content,
      question_type: resource.question_type,
      question_options: resource.question_options.order(:position),
      correct_answer: resource.correct_answer,
      created_at: resource.created_at,
      updated_at: resource.updated_at
    }
  end

  # Summary Hash response
  def summary_hash
    {
      id: resource.id,
      assessment_id: resource.assessment_id,
      content: resource.content,
      created_at: resource.created_at,
      updated_at: resource.updated_at
    }
  end
end
