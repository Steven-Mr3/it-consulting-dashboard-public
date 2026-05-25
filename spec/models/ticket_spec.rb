require 'rails_helper'

RSpec.describe Ticket, type: :model do
  describe 'associations' do
    it { should belong_to(:client) }
    it { should belong_to(:assigned_to).class_name('User').optional }
    it { should belong_to(:created_by).class_name('User') }
    it { should has_many(:comments).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:priority) }
    it { should validate_presence_of(:category) }
  end

  describe 'enums' do
    it { should define_enum_for(:status).with_values(open: 0, in_progress: 1, resolved: 2, closed: 3).with_prefix }
    it { should define_enum_for(:priority).with_values(low: 0, medium: 1, high: 2, critical: 3) }
    it { should define_enum_for(:category).with_values(incident: 0, request: 1, change: 2, problem: 3) }
  end
end
