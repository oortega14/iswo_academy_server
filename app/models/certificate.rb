# Define Certificate Model
class Certificate < ApplicationRecord
  # Associations
  belongs_to :course
  belongs_to :user

  # Associated blobs
  has_one_attached :file

  # Callbacks
  after_create :create_file

  def create_file
    pdf_file = ActiveStorage::Blob.create_and_upload!(
      io: Exams::GenerateCertificate.new(self).call,
      filename: 'certificate.pdf',
      content_type: 'pdf'
    )
    file.attach(pdf_file)
    save
    file_path = "public/certificates/certificate_#{id}.pdf"
    File.delete(file_path) if File.exist?(file_path)
  end
end
