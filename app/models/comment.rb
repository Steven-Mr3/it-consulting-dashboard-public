class Comment < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :ticket

  # Validations
  validates :body, presence: true

  # Scopes
  scope :recent, -> { order(created_at: :desc) }
end
