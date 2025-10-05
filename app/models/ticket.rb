class Ticket < ApplicationRecord
  # Enums
  enum :status, { open: 0, in_progress: 1, resolved: 2, closed: 3 }, prefix: true
  enum :priority, { low: 0, medium: 1, high: 2, critical: 3 }
  enum :category, { incident: 0, request: 1, change: 2, problem: 3 }

  # Associations
  belongs_to :client
  belongs_to :assigned_to, class_name: 'User', optional: true
  belongs_to :created_by, class_name: 'User'
  has_many :comments, dependent: :destroy
  has_many :alerts, dependent: :destroy

  # Validations
  validates :title, presence: true
  validates :description, presence: true
  validates :status, presence: true
  validates :priority, presence: true
  validates :category, presence: true

  # Scopes
  scope :open, -> { where(status: [:open, :in_progress]) }
  scope :urgent, -> { where(priority: [:high, :critical]) }
  scope :overdue, -> { where("created_at + (clients.sla_response_time * interval '1 minute') < ?", Time.current).joins(:client) }

  # Callbacks
  before_save :set_resolved_at, if: :status_changed_to_resolved?

  # Methods
  def response_time_minutes
    return nil unless resolved_at
    ((resolved_at - created_at) / 60).round
  end

  def within_sla?
    return nil unless resolved_at
    response_time_minutes <= client.sla_response_time
  end

  def overdue?
    return false if status_resolved? || status_closed?
    (Time.current - created_at) / 60 > client.sla_response_time
  end

  private

  def status_changed_to_resolved?
    status_changed? && status_resolved?
  end

  def set_resolved_at
    self.resolved_at = Time.current
  end
end
