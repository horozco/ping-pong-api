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

  context 'match methods' do
    let!(:p1) { FactoryGirl.create(:player) }
    let!(:p2) { FactoryGirl.create(:player) }
    let!(:p3) { FactoryGirl.create(:player) }
    let!(:p4) { FactoryGirl.create(:player) }
    let!(:p5) { FactoryGirl.create(:player) }
    let!(:p6) { FactoryGirl.create(:player) }
    let!(:m1) { FactoryGirl.create(:match, winner: p1, loser: p2) }
    let!(:m2) { FactoryGirl.create(:match, winner: p3, loser: p5) }
    let!(:m3) { FactoryGirl.create(:match, winner: p5, loser: p1) }
    let!(:m4) { FactoryGirl.create(:match, winner: p1, loser: p3) }
    let!(:m5) { FactoryGirl.create(:match, winner: p6, loser: p5) }
    let!(:m6) { FactoryGirl.create(:match, winner: p4, loser: p2) }

    describe 'played_matches' do
      it { expect(p1.played_matches.count).to eq(3) }
      it { expect(p2.played_matches.count).to eq(2) }
      it { expect(p3.played_matches.count).to eq(2) }
      it { expect(p4.played_matches.count).to eq(1) }
      it { expect(p5.played_matches.count).to eq(3) }
      it { expect(p6.played_matches.count).to eq(1) }
    end

    describe 'won_matches' do
      it { expect(p1.won_matches.count).to eq(2) }
      it { expect(p2.won_matches.count).to eq(0) }
      it { expect(p3.won_matches.count).to eq(1) }
      it { expect(p4.won_matches.count).to eq(1) }
      it { expect(p5.won_matches.count).to eq(1) }
      it { expect(p6.won_matches.count).to eq(1) }
    end

    describe 'lost_matches' do
      it { expect(p1.lost_matches.count).to eq(1) }
      it { expect(p2.lost_matches.count).to eq(2) }
      it { expect(p3.lost_matches.count).to eq(1) }
      it { expect(p4.lost_matches.count).to eq(0) }
      it { expect(p5.lost_matches.count).to eq(2) }
      it { expect(p6.lost_matches.count).to eq(0) }
    end
  end
end
