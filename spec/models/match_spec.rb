# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Match, type: :model do
  before { @match = FactoryGirl.build(:match) }

  subject { @match }

  # Existing attributes
  it { should respond_to(:winner_id) }
  it { should respond_to(:loser_id) }
  it { should respond_to(:winner_score) }
  it { should respond_to(:loser_score) }

  # Associations
  it { should belong_to(:winner).class_name('Player') }
  it { should belong_to(:loser).class_name('Player') }

  # Required fields
  it { should validate_presence_of :winner_id }
  it { should validate_presence_of :loser_id }
  it { should validate_presence_of :winner_score }
  it { should validate_presence_of :loser_score }

  # Numericality validations
  it { should validate_numericality_of(:winner_score) }
  it { should validate_numericality_of(:loser_score) }

  # Custom validations
  context 'minimum_margin' do
    let(:match) { FactoryGirl.build(:match, winner_score: winner_score, loser_score: loser_score) }
    describe 'when the margin is valid' do
      let(:winner_score) { 21 }
      let(:loser_score) { 19 }
      it { expect(match).to be_valid }
    end

    describe 'when the margin is invalid' do
      let(:winner_score) { 21 }
      let(:loser_score) { 20 }
      before { match.valid? }
      it { expect(match).not_to be_valid }
      it { expect(match.errors).to be_present }
      it { expect(match.errors['margin']).to be_present }
      it { expect(match.errors['margin'][0]).to eq('The game needs to be won by a two point minimum margin') }
    end
  end

  context 'minimum_winner_score' do
    let(:match) { FactoryGirl.build(:match, winner_score: winner_score, loser_score: winner_score - 2) }
    describe 'when the winner_score is valid' do
      let(:winner_score) { [21, 22, 23].sample }
      it { expect(match).to be_valid }
    end

    describe 'when the winner_score is invalid' do
      let(:winner_score) { 19 }
      before { match.valid? }
      it { expect(match).not_to be_valid }
      it { expect(match.errors).to be_present }
      it { expect(match.errors['winner_score']).to be_present }
      it { expect(match.errors['winner_score'][0]).to eq('The minimum winner score is 21') }
    end
  end

  it { should be_valid }

  context '#creating' do
    it 'adds a new record' do
      expect { @match.save }.to change(Match, :count).by(1)
    end
  end

  context 'elo rating update' do
    let(:starting_rating) { 1500 }
    let(:player1) { FactoryGirl.create(:player, rating: starting_rating, wins: 0, loses: 0) }
    let(:player2) { FactoryGirl.create(:player, rating: starting_rating, wins: 0, loses: 0) }
    let!(:match_instance) { FactoryGirl.build(:match, winner: player1, loser: player2) }
    before { match_instance.save }
    
    describe 'changing the players rating' do
      it { expect(player1.rating).to be > starting_rating }
      it { expect(player2.rating).to be < starting_rating }
    end

    describe 'changing the players wins and loses' do
      it { expect(player1.wins).to be(1) }
      it { expect(player1.loses).to be(0) }
      it { expect(player2.loses).to be(1) }
      it { expect(player2.wins).to be(0) }
    end
  end
end
