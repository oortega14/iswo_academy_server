class SocialNetwork < ApplicationRecord
  belongs_to :user_detail

  validates :platform, presence: true
  validates :url, presence: true, format: { with: URI::DEFAULT_PARSER.make_regexp, message: 'must be a valid URL' }
end
