class FileAttachment < Attachment
  has_one_attached :file

  validate :file_must_be_present

  def file_must_be_present
    errors.add(:file, 'debe subirse un archivo') unless file.attached?
  end
end
