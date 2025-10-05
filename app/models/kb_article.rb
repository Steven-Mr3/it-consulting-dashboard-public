class KbArticle < ApplicationRecord
  # Validations
  validates :title, presence: true
  validates :content, presence: true
  validates :category, presence: true

  # Scopes
  scope :most_viewed, -> { order(views_count: :desc) }
  scope :most_helpful, -> { order(helpful_count: :desc) }
  scope :by_category, ->(category) { where(category: category) if category.present? }

  # Methods
  def increment_views!
    increment!(:views_count)
  end

  def mark_helpful!
    increment!(:helpful_count)
  end

  def mark_unhelpful!
    increment!(:unhelpful_count)
  end

  def helpfulness_rating
    total = helpful_count + unhelpful_count
    return 0 if total.zero?
    (helpful_count.to_f / total * 100).round(2)
  end
end
