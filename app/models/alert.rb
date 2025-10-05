class Alert < ApplicationRecord
  # Enums
  enum :severity, { info: 0, warning: 1, critical: 2 }

  # Associations
  belongs_to :ticket, optional: true

  # Validations
  validates :alert_type, presence: true
  validates :message, presence: true
  validates :severity, presence: true

  # Scopes
  scope :active, -> { where(resolved: false) }
  scope :by_severity, ->(severity) { where(severity: severity) if severity.present? }

  # Methods
  def resolve!
    update(resolved: true)
  end
end
