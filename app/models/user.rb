class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Enums
  enum :role, { admin: 0, consultant: 1, client_user: 2 }

  # Associations
  belongs_to :client, optional: true
  has_many :created_tickets, class_name: 'Ticket', foreign_key: 'created_by_id', dependent: :nullify
  has_many :assigned_tickets, class_name: 'Ticket', foreign_key: 'assigned_to_id', dependent: :nullify
  has_many :comments, dependent: :destroy

  # Validations
  validates :name, presence: true
  validates :role, presence: true

  # Scopes
  scope :admins, -> { where(role: :admin) }
  scope :consultants, -> { where(role: :consultant) }
  scope :clients, -> { where(role: :client_user) }
end
