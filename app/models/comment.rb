class Comment < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :commentable, polymorphic: true

  has_many :replies, class_name: 'Comment', foreign_key: 'parent_id', dependent: :destroy
  belongs_to :parent, class_name: 'Comment', optional: true

  # Validations
  validates :body, presence: true
end
