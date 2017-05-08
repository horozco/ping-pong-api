# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Statistics, type: :model do
  
  context 'leaders' do
    describe 'Get the leader board' do
      let!(:p1) { FactoryGirl.create(:player, rating: 1000, wins: 0, loses: 0) }
      let!(:p2) { FactoryGirl.create(:player, rating: 1000, wins: 0, loses: 0) }
      let!(:p3) { FactoryGirl.create(:player, rating: 1000, wins: 0, loses: 0) }
      let!(:p4) { FactoryGirl.create(:player, rating: 1000, wins: 0, loses: 0) }
      let!(:p5) { FactoryGirl.create(:player, rating: 1000, wins: 0, loses: 0) }
      let!(:p6) { FactoryGirl.create(:player, rating: 1000, wins: 0, loses: 0) }
      let!(:m1) { FactoryGirl.create(:match, winner: p1, loser: p6) }
      let!(:m2) { FactoryGirl.create(:match, winner: p1, loser: p6) }
      let!(:m3) { FactoryGirl.create(:match, winner: p1, loser: p6) }
      let!(:m4) { FactoryGirl.create(:match, winner: p2, loser: p5) }
      let!(:m4) { FactoryGirl.create(:match, winner: p2, loser: p5) }
      let!(:m4) { FactoryGirl.create(:match, winner: p3, loser: p4) }
      let!(:m4) { FactoryGirl.create(:match, winner: p3, loser: p4) }
      before { @leaders = Statistics.leaders }

      it { expect(@leaders[0]).to eq(p1) }
      it { expect(@leaders[1]).to eq(p3) }
      it { expect(@leaders[2]).to eq(p2) }
      it { expect(@leaders[3]).to eq(p5) }
      it { expect(@leaders[4]).to eq(p4) }
      it { expect(@leaders[5]).to eq(p6) }
    end
  end

end
