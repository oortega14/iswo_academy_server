class Attachment < ApplicationRecord
  # Constants
  CATEGORIES = %w[promotional_video video_class study_material extra_resource].freeze

  # Associations
  belongs_to :attachable, polymorphic: true

  # Validations
  validates :type, presence: true
  validates :category, inclusion: { in: CATEGORIES }

  # Scopes
  scope :file_attachments, -> { where(type: 'FileAttachment') }
  scope :url_attachments, -> { where(type: 'UrlAttachment') }

  # Methods
  def file_attachment?
    is_a?(FileAttachment)
  end

  def url_attachment?
    is_a?(UrlAttachment)
  end
end
