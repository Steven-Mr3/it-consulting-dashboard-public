class Client < ApplicationRecord
  # Associations
  has_many :tickets, dependent: :destroy
  has_many :users, dependent: :nullify

  # Validations
  validates :name, presence: true
  validates :contact_email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :sla_response_time, presence: true, numericality: { greater_than: 0 }

  # Methods
  def active?
    contract_end.nil? || contract_end >= Date.today
  end

  def sla_compliance_rate
    total = tickets.resolved.count
    return 0 if total.zero?

    within_sla = tickets.resolved.where("resolved_at <= created_at + (sla_response_time * interval '1 minute')").count
    (within_sla.to_f / total * 100).round(2)
  end
end
