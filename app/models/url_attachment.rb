class UrlAttachment < Attachment
  validates :url, presence: true, format: { with: URI::DEFAULT_PARSER.make_regexp, message: 'debe ser una URL válida' }
end
