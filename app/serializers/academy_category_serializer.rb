class AcademyCategorySerializer < BaseSerializer
  def serializable_hash
    full_hash
  end

  private

  # Full Hash response
  def full_hash
    {
      id: resource.id,
      name: I18n.t("academy_categories.#{resource.name}"),
      description: resource.description
    }
  end
end
