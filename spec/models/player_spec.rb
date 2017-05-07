# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Player, type: :model do
  before { @player = FactoryGirl.build(:player) }

  subject { @player }

  # Existing attributes
  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:auth_token) }
  it { should respond_to(:rating) }
  it { should respond_to(:wins) }
  it { should respond_to(:loses) }

  # Required fields
  it { should validate_presence_of :name }
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }

  # Unique validations
  it { should validate_uniqueness_of(:email).case_insensitive }

  # Numericality validations
  it { should validate_numericality_of(:rating) }
  it { should validate_numericality_of(:wins) }
  it { should validate_numericality_of(:loses) }

  # Password confirmation validation
  it { should validate_confirmation_of(:password) }

  it { should be_valid }

  context '#creating' do
    it 'adds a new record' do
      expect { @player.save }.to change(Player, :count).by(1)
    end
  end
end
