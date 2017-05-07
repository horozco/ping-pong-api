# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::MatchesController, type: :controller do
  it { expect(v1_matches_path).to eq('/v1/matches') }
  it {
    expect(post: v1_matches_url).to route_to(controller: 'api/v1/matches',
                                             action:     'create',
                                             subdomain:  'api',
                                             format:     :json)
  }
  it {
    expect(get: v1_matches_url).to route_to(controller: 'api/v1/matches',
                                          action:     'index',
                                          subdomain:  'api',
                                          format:     :json)
  }

  describe 'authentication is required to' do
    [
      { method: 'post',    action: 'create',   params: { format: :json, params: { id: 0 } } },
      { method: 'get',     action: 'index',    params: { format: :json } },
    ].each do |request|
      context "#{request[:method].upcase} ##{request[:action]}" do
        before do
          send(request[:method].to_sym, request[:action].to_sym, request[:params])
        end

        it { should                       respond_with(401) }
        it { expect(response).to          have_http_status(401) }
        it { expect(errors).not_to        be_nil }
        it { expect(errors['title']).to   match('Not authorized') }
        it { expect(errors['detail']).to  match('Not authorized') }
      end
    end
  end

  describe 'GET #index' do
    let(:player)  { FactoryGirl.create(:player) }
    let!(:matches) { FactoryGirl.create_list(:match, 4) }
    let(:params) do
      {}
    end

    before { request.headers['Authorization'] = player.auth_token }

    context 'with valid attributes' do
      before(:each) do
        get :index, format: :json, params: params
      end

      it { should respond_with 200 }
      it { expect(response).to have_http_status(200) } 
      it { expect(json.count).to eq(matches.count) }
    end
  end

  describe 'POST #create' do
    let(:player)  { FactoryGirl.create(:player) }
    let(:winner)  { FactoryGirl.create(:player) }
    let(:loser)   { FactoryGirl.create(:player) }
    before { request.headers['Authorization'] = player.auth_token }

    let(:params) do
      {
        match: {
          winner_id: winner.id,
          loser_id: loser.id,
          winner_score: FactoryGirl.attributes_for(:match)[:winner_score],
          loser_score: FactoryGirl.attributes_for(:match)[:loser_score]
        }
      }
    end

    context 'with valid attributes' do
      before(:each) do
        post :create, format: :json, params: params
      end

      it { should respond_with 200 }
      it { expect(response).to have_http_status(200) }
      it { expect(json['id']).to be_present }
      it { expect(json['winner']).to be_present }
      it { expect(json['loser']).to be_present }
      it { expect(json['winner_score']).to eq(params[:match][:winner_score]) }
      it { expect(json['loser_score']).to eq(params[:match][:loser_score]) }
    end

    %w[winner_id loser_id winner_score loser_score].each do |field_name|
      context "without #{field_name}" do
        before(:each) do
          params[:match][field_name.to_sym] = ''
          post :create, format: :json, params: params
        end

        it { should respond_with 422 }
        it { expect(response).to have_http_status(422) }
        it { expect(JSON.parse(errors['detail'])[field_name]).not_to be_nil }
        it { expect(JSON.parse(errors['detail'])[field_name].first).to match('can\'t be blank') }
      end
    end
  end
end
